require 'ostruct'

module Docbot
  class RubyDoc
    def fetch_symbol_doc(symbol)
      symbol_doc = `bundle exec ri #{symbol} 2>&1`

      OpenStruct.new(symbol_doc: symbol_doc, success: $?.success?)
    end
  end
end
