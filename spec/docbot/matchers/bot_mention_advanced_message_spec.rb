require 'spec_helper'
require 'docbot/matchers/bot_mention_advanced_message'

RSpec.describe Docbot::Matchers::BotMentionAdvancedMessage do
  describe '#match' do
    context 'when the bot was mentioned followed by the phrase "please explain"' do
      it 'should return the symbol candidate' do
        bot_id = '1'
        message = "<@#{bot_id}>: please explain Array#first"

        symbol = Docbot::Matchers::BotMentionAdvancedMessage.match(message, bot_id)
        expect(symbol).to eq('Array#first')
      end
    end
  end

  describe '#pattern' do
    it 'should return the pattern matched by the matcher' do
      pattern = Docbot::Matchers::BotMentionAdvancedMessage.pattern

      expect(pattern).to eq('@docbot: please explain Array#first')
    end
  end
end
