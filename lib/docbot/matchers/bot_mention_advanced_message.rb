require 'docbot/matcher'

module Docbot
  module Matchers
    class BotMentionAdvancedMessage < Docbot::Matcher
      def self.pattern(bot_id)
        /\A<@#{bot_id}>:{0,1}\s*please\s+explain (?<symbol>\S+)$/
      end

      def self.pattern_example(bot_name)
        "@#{bot_name}: please explain Array#first"
      end
    end
  end
end
