require 'ostruct'

module Docbot
  # Internal: An object to fetch Ruby Documentation using the ri command.
  class RubyDoc
    # Public: fetches the Ruby documentation for class, module or method.
    #
    # symbol - The String Ruby class, module or method name.
    #
    # Examples
    #
    #   fetch_symbol_doc('Array#first')
    #   # =>  <OpenStruct text="# Array#first ...", success=true,
    #        symbol="Array#first">
    #
    # Returns the symbol documentation OpenStruct.
    def fetch_symbol_doc(symbol)
      symbol_doc = `bundle exec ri --format=markdown '#{symbol}' 2>&1`

      OpenStruct.new(text: symbol_doc, success: $?.success?, symbol: symbol)
    end
  end
end
