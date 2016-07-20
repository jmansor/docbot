require 'docbot/matcher'

module Docbot
  module Matchers
    # Internal: A class to identify Slack messages that request Ruby
    # Documenation with the format '@docbot: Array#first', where all the
    # message contains is a mention to the bot followed by the symbol for which
    # the documentation is requested.
    class BotMentionDirectMessage < Docbot::Matcher
      # Public: defines the pattern this matcher will apply.
      #
      # bot_id  - The String slack bot id.
      #
      # Examples
      #
      #   pattern('1234')
      #   # => /\A<@1234>:{0,1}\s*(?<symbol>\S+)$/
      #
      # Returns the Regex this matcher will apply.
      def self.pattern(bot_id)
        /\A<@#{bot_id}>:{0,1}\s*(?<symbol>\S+)$/
      end

      # Public: provides an example of a message that this matcher would match.
      #
      # bot_name  - The String slack bot id.
      #
      # Examples
      #
      #   pattern_example('rubydocbot')
      #   # => "@rubydocbot: Array#first"
      #
      # Returns the message example String that this matcher would match.
      def self.pattern_example(bot_name)
        "@#{bot_name}: Array#first"
      end
    end
  end
end
