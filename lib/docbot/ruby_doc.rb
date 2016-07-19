require 'ostruct'

module Docbot
  class RubyDoc
    def fetch_symbol_doc(symbol)
      symbol_doc = `bundle exec ri --format=markdown #{symbol} 2>&1`

      OpenStruct.new(text: symbol_doc, success: $?.success?, symbol: symbol)
    end
  end
end
