require 'spec_helper'
require 'docbot/matchers/bot_mention_direct_message'

RSpec.describe Docbot::Matchers::BotMentionDirectMessage do
  describe '#match' do
    context 'when the bot was mentioned followed immediately by a single word' do
      it 'should return the symbol candidate' do
        bot_id = '1'
        message = "<@#{bot_id}>: Array#first"

        symbol = Docbot::Matchers::BotMentionDirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array#first')
      end
    end
  end
end
