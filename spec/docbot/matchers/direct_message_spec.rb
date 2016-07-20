require 'spec_helper'
require 'docbot/matchers/direct_message'

RSpec.describe Docbot::Matchers::DirectMessage do
  describe '#match' do
    context 'when the slack message has only one word' do
      it 'should return the symbol candidate' do
        bot_id = '1'

        message = "Array#first"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array#first')

        message = "Array#first"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array#first')

        message = "Array"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array')

        message = "Array.first"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array.first')

        message = "ACL::ACLEntry"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to eq('ACL::ACLEntry')

        message = "Array#first I need to know what id does"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to be_nil

        message = " Array#first"
        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to be_nil
      end
    end

    context 'when the slack message has more than one word' do
      it 'should return nil' do
        message = 'Word1 Word2'
        bot_id = '1'

        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)

        expect(symbol).to be_nil
      end
    end
  end

  describe '#pattern_example' do
    it 'should return a pattern example matched by the matcher' do
      pattern = Docbot::Matchers::DirectMessage.pattern_example

      expect(pattern).to eq('Array#first')
    end
  end
end
