require 'docbot/matcher'

module Docbot
  module Matchers
    class BotMentionDirectMessage < Docbot::Matcher
      def self.pattern(bot_id)
        /^<@#{bot_id}>:{0,1}\s*(?<symbol>\S+)$/
      end

      def self.pattern_example
        '@docbot: Array#first'
      end
    end
  end
end
