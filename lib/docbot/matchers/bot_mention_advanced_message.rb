module Docbot
  module Matchers
    class BotMentionAdvancedMessage
      def self.match(message, bot_id)
        symbol_candidate = nil
        pattern = /^<@#{bot_id}>:{0,1}\s*please\s+explain (?<symbol>\S+)$/
        matches = pattern.match(message)
        if !matches.nil? && !matches[:symbol].nil?
          symbol_candidate = matches[:symbol]
        end

        symbol_candidate
      end

      def self.pattern
        '@docbot: please explain Array#first'
      end
    end
  end
end
