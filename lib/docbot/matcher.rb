module Docbot
  class Matcher
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
