module Docbot
  module Matchers
    class BotMentionDirectMessage
      def self.match(message, bot_id)
        symbol_candidate = nil
        splitted_message = message.split
        if splitted_message.count == 2
          bot_mention_candidate = splitted_message[0]
          if bot_mention_candidate == "<@#{bot_id}>:"
            symbol_candidate = splitted_message[1]
          end
        end

        symbol_candidate
      end

      def self.pattern
        '@docbot: Array#first'
      end
    end
  end
end
