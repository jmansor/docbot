require 'docbot/matcher'

module Docbot
  module Matchers
    class BotMentionDirectMessage < Docbot::Matcher
      def self.pattern(bot_id)
        /\A<@#{bot_id}>:{0,1}\s*(?<symbol>\S+)$/
      end

      def self.pattern_example(bot_name)
        "@#{bot_name}: Array#first"
      end
    end
  end
end
