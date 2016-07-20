module Docbot
  # Internal: A class to identify Slack messages that request Ruby
  # Documenation from the bot.
  class Matcher
    # Public: parses a Slack message to identify a potential Ruby documentation
    # request.
    #
    # message - The String message coming from Slack.
    # bot_id  - The String slack bot id.
    #
    # Examples
    #
    #   Docbot::Matcher.match('<@1234>: Array#first', '1234')
    #   # => "Array#first"
    #
    # Returns the symbol candidate String from which the bot will try to fetch
    # the Ruby documenation.
    def self.match(message, bot_id)
      symbol = nil

      matches = self.pattern(bot_id).match(message)
      if !matches.nil? && !matches[:symbol].nil?
        symbol_candidate = matches[:symbol]
      end

      symbol_candidate
    end

    def self.pattern
      raise 'Must implement in child class.'
    end
  end
end
