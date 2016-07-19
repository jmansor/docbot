module Docbot
  module Matchers
    class DirectMessage
      def self.match(message, bot_id)
        symbol = nil
        if message.split.count == 1
          symbol = message
        end

        symbol
      end

      def self.pattern
        'Array#first'
      end
    end
  end
end
