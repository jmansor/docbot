module Docbot
  module Matchers
    class BotMentionAdvancedMessage
      def self.match(message, bot_id)
        symbol_candidate = nil
        splitted_message = message.split
        if splitted_message.count == 4
          bot_mention_candidate = splitted_message[0]
          if bot_mention_candidate == "<@#{bot_id}>:" && splitted_message[1] == 'please' && splitted_message[2] == 'explain'
            symbol_candidate = splitted_message[3]
          end
        end

        symbol_candidate
      end

      def self.pattern
        '@docbot: please explain Array#first'
      end
    end
  end
end
