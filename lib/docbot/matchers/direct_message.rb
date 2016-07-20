module Docbot
  module Matchers
    class DirectMessage
      def self.match(message, bot_id)
        symbol = nil

        pattern = /^(?<symbol>\S+)$/
        matches = pattern.match(message)
        if !matches.nil? && !matches[:symbol].nil?
          symbol_candidate = matches[:symbol]
        end

        symbol_candidate
      end

      def self.pattern
        'Array#first'
      end
    end
  end
end
