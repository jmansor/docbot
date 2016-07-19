require 'spec_helper'
require 'docbot/ruby_doc'

describe Docbot::RubyDoc do
  describe '#fetch_symbol_doc' do
    it 'should return the documentation of the specified symbol' do
      ruby_doc = Docbot::RubyDoc.new

      symbol_doc = ruby_doc.fetch_symbol_doc('Array')
      expect(symbol_doc.symbol_doc.length).to be > 0
      expect(symbol_doc.success).to eq(true)

      symbol_doc = ruby_doc.fetch_symbol_doc('Array#first')
      expect(symbol_doc.symbol_doc.length).to be > 0
      expect(symbol_doc.success).to eq(true)

      symbol_doc = ruby_doc.fetch_symbol_doc('Arroy')
      expect(symbol_doc.symbol_doc).to eq("Nothing known about Arroy\n")
      expect(symbol_doc.success).to eq(false)

      symbol_doc = ruby_doc.fetch_symbol_doc('Array#i_dont_exist')
      expect(symbol_doc.symbol_doc).to eq("Nothing known about Array#i_dont_exist\n")
      expect(symbol_doc.success).to eq(false)
    end
  end
end
