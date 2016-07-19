require 'slack-ruby-client'
require 'docbot/ruby_doc'
require 'docbot/matchers/direct_message'
require 'docbot/matchers/bot_mention_direct_message'
require 'docbot/matchers/bot_mention_advanced_message'

module Docbot
  class Bot
    MATCHERS = [
      Docbot::Matchers::DirectMessage,
      Docbot::Matchers::BotMentionDirectMessage,
      Docbot::Matchers::BotMentionAdvancedMessage
    ]

    def initialize
      @client = Slack::RealTime::Client.new
      @ruby_doc = Docbot::RubyDoc.new
    end

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

    def must_respond?(symbol_doc)
      !symbol_doc.nil?
    end

    def needs_help?(message, bot_id)
      needs_help = false
      needs_help_patterns = [
        /^<@#{bot_id}>$/,
        /^<@#{bot_id}>:$/,
        /^<@#{bot_id}>:\s*help$/
      ]

      needs_help_patterns.each do |pattern|
        needs_help ||= !pattern.match(message).nil?
      end

      needs_help
    end

    def respond_ok(symbol_doc)
      symbol_doc.text
    end

    def respond_error(symbol_doc)
      "I'm sorry, I could not find any documentation for _#{symbol_doc.symbol}_"
    end

    def respond_help
      help = []
      help << "Hi human, if you need documentation about any Ruby Core/Stdlib class, module or method, you can ask me in this way:"
      help << ''
      MATCHERS.each do |matcher|
        help << "_#{matcher.pattern}_"
      end

      help << ''
      help << 'I understand any of the following formats:'
      help << '_Class | Module | Module::Class | Class::method | Class#method | Class.method | method_'

      help.join("\n")
    end
  end
end
