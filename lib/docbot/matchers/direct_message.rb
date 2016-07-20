require 'docbot/matcher'

module Docbot
  module Matchers
    class DirectMessage < Docbot::Matcher
      def self.pattern(bot_id)
        /^(?<symbol>\S+)$/
      end

      def self.pattern_example(bot_name)
        'Array#first'
      end
    end
  end
end
