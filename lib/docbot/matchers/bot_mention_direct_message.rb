module Docbot
  module Matchers
    class BotMentionDirectMessage
      def self.match(message, bot_id)
        symbol_candidate = nil

        pattern = /^<@#{bot_id}>:{0,1}\s*(?<symbol>\S+)$/
        matches = pattern.match(message)
        if !matches.nil? && !matches[:symbol].nil?
          symbol_candidate = matches[:symbol]
        end

        symbol_candidate
      end

      def self.pattern
        '@docbot: Array#first'
      end
    end
  end
end
