require 'slack-ruby-client'
require 'docbot/ruby_doc'
require 'docbot/matchers/direct_message'
require 'docbot/matchers/bot_mention_direct_message'
require 'docbot/matchers/bot_mention_advanced_message'

module Docbot
  # Public: An object to create a Slack bot that can be requested for Ruby
  # documentation for Ruby Core/Stdlib classes, modules and methods.
  class Bot
    # Public: Array with the matchers that will be applied by this Bot.
    MATCHERS = [
      Docbot::Matchers::DirectMessage,
      Docbot::Matchers::BotMentionDirectMessage,
      Docbot::Matchers::BotMentionAdvancedMessage
    ]

    # Public: Initialize a Bot.
    #
    # client   - A Slack::Realtime::Client to connect to Slack RTM API.
    # ruby_doc - A Docbot::RubyDoc to fetch Ruby Documentation
    def initialize(client, ruby_doc)
      @client = client
      @ruby_doc = ruby_doc
    end

    # Public: starts the bot server and binds the slack rtm client events
    #
    # Returns Nothing.
    def start
      @client.on :hello do
        puts "Successfully connected, welcome '#{@client.self.name}' to the '#{@client.team.name}' team at https://#{@client.team.domain}.slack.com."
      end
      @client.on :close do |_data|
        puts "Client is about to disconnect"
      end
      @client.on :closed do |_data|
        puts "Client has disconnected successfully!"
      end

      @client.on :message do |data|
        message = data.text
        bot_id = @client.self.id
        if self.needs_help?(message, bot_id)
          @client.message channel: data.channel, text: self.respond_help
        else
          symbol_doc = self.read(message, bot_id)
          if self.must_respond?(symbol_doc)
            if symbol_doc.success
              @client.message channel: data.channel, text: self.respond_ok(symbol_doc)
            else
              if message.split.count > 1
                @client.message channel: data.channel, text: self.respond_error(symbol_doc)
              end
            end
          end
        end
      end

      @client.start!
    end

    # Public: read a Slack message and figure out if ruby doc was requested to
    #         the bot.
    #
    # message - The String message coming from Slack.
    # bot_id  - The String slack bot id.
    #
    # Examples
    #
    #   read('<@1234>: Array#first', '1234')
    #   # => <OpenStruct text="# Array#first ...", success=true,
    #        symbol="Array#first">
    #
    # Returns the symbol documentation OpenStruct or nil the message was not
    # for the bot.
    def read(message, bot_id)
      symbol_candidate = nil
      symbol_doc = nil
      MATCHERS.each do |matcher|
        symbol_candidate = matcher.match(message, bot_id)
        if !symbol_candidate.nil?
          symbol_doc = @ruby_doc.fetch_symbol_doc(symbol_candidate)
          break
        end
      end

      symbol_doc
    end

    # Public: indicates if a Slack message is for the bot
    #
    # symbol_doc - The OpenStruct with the requested documentation or nil.
    #
    # Examples
    #
    #   must_respond?(<OpenStruct text="# Array#first ...", success=true,
    #     symbol="Array#first">)
    #   # => true
    #
    #   must_respond?(nil)
    #   # => false
    #
    # Returns true if the bot must respond, false otherwise.
    def must_respond?(symbol_doc)
      !symbol_doc.nil?
    end

    # Public: indicates if a Slack message is a help message for the bot
    #
    # message - The String message coming from Slack.
    # bot_id  - The String slack bot id.
    #
    # Examples
    #
    #   needs_help?('<@1234>', '1234')
    #   # => true
    #
    #   needs_help?('<@1234>: Array#first', '1234')
    #   # => false
    #
    # Returns true if the message is a help message for the bot, false
    # otherwise.
    def needs_help?(message, bot_id)
      needs_help = false
      needs_help_patterns = [
        /\A<@#{bot_id}>$/,
        /\A<@#{bot_id}>:$/,
        /\A<@#{bot_id}>:\s*help$/
      ]

      needs_help_patterns.each do |pattern|
        needs_help ||= !pattern.match(message).nil?
      end

      needs_help
    end

    # Public: generates the response message for the user that requested a
    # valid documentation entry.
    #
    # symbol_doc - The OpenStruct with the requested documentation or nil.
    #
    # Examples
    #
    #   respond_ok(<OpenStruct text="# Array#first ...", success=true,
    #     symbol="Array#first">)
    #   # => "# Array#first ..."
    #
    # Returns the text of requested Ruby documentation String.
    def respond_ok(symbol_doc)
      symbol_doc.text
    end

    # Public: generates the response message for the user that requested a
    # invalid documentation entry.
    #
    # symbol_doc - The OpenStruct with the requested documentation or nil.
    #
    # Examples
    #
    #   respond_ok(<OpenStruct text="No documentation found", success=false,
    #     symbol="Array#fist">)
    #   # => "I'm sorry, I could not find any documentation for _Array#fist_"
    #
    # Returns an error message String indicating no documentation was found.
    def respond_error(symbol_doc)
      "I'm sorry, I could not find any documentation for _#{symbol_doc.symbol}_"
    end

    # Public: generates the response message for the user that requested the
    # bot help text.
    #
    # Returns the bot help text String.
    def respond_help
      help = []
      help << "Hi human, if you need documentation about any Ruby Core/Stdlib class, module or method, you can ask me in this way:"
      help << ''
      MATCHERS.each do |matcher|
        help << "_#{matcher.pattern_example(@client.self.name)}_"
      end

      help << ''
      help << 'I understand any of the following formats:'
      help << '_Class | Module | Module::Class | Class::method | Class#method | Class.method | method_'

      help.join("\n")
    end
  end
end
