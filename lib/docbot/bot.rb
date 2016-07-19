require 'slack-ruby-client'
require_relative 'matchers/direct_message'
require_relative 'matchers/bot_mention_direct_message'
require_relative 'matchers/bot_mention_advanced_message'

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

    def bind_events
      @client.on :message do |data|
        symbol_doc = self.read(data.text)
        if self.must_respond?(symbol_doc)
          @client.message channel: data.channel, text: self.respond_ok
        else
          @client.message channel: data.channel, text: self.respond_error
        end
      end
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
      symbol_doc.success && symbol_doc.text.length > 0
    end

    def respond_ok(symbol_doc)
      symbol_doc.text
    end

    def respond_error(symbol_doc)
      "I'm sorry, I could not find any documentation for #{symbol_doc.symbol}"
    end
  end
end
