require 'spec_helper'
require 'docbot/matchers/direct_message'

RSpec.describe Docbot::Matchers::DirectMessage do
  describe '#match' do
    context 'when the slack message has only one word' do
      it 'should return the symbol candidate' do
        message = 'Array#first'
        bot_id = '1'

        symbol = Docbot::Matchers::DirectMessage.match(message, bot_id)
        expect(symbol).to eq(message)
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

  describe '#pattern' do
    it 'should return the pattern matched by the matcher' do
      pattern = Docbot::Matchers::DirectMessage.pattern

      expect(pattern).to eq('Array#first')
    end
  end
end
