require_relative 'matchers/direct_message'
require_relative 'matchers/bot_mention_direct_message'
require_relative 'matchers/bot_mention_advanced_message'

module Docbot
  class RubyDocMessageMatcher
    MATCHERS = [
      Docbot::Matchers::DirectMessage,
      Docbot::Matchers::BotMentionDirectMessage,
      Docbot::Matchers::BotMentionAdvancedMessage
    ]

    def initialize(ruby_doc)
      @ruby_doc = ruby_doc
    end

    def parse(message, bot_id)
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
  end
end
