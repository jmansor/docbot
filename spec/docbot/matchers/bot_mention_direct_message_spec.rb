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

        message = "<@#{bot_id}>:Array#first"
        symbol = Docbot::Matchers::BotMentionDirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array#first')

        message = "<@#{bot_id}>: Array"
        symbol = Docbot::Matchers::BotMentionDirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array')

        message = "<@#{bot_id}>: Array.first"
        symbol = Docbot::Matchers::BotMentionDirectMessage.match(message, bot_id)
        expect(symbol).to eq('Array.first')

        message = "<@#{bot_id}>: ACL::ACLEntry"
        symbol = Docbot::Matchers::BotMentionDirectMessage.match(message, bot_id)
        expect(symbol).to eq('ACL::ACLEntry')

        message = "<@#{bot_id}>: Array#first I need to know what id does"
        symbol = Docbot::Matchers::BotMentionDirectMessage.match(message, bot_id)
        expect(symbol).to be_nil
      end
    end
  end

  describe '#pattern' do
    it 'should return the pattern matched by the matcher' do
      pattern = Docbot::Matchers::BotMentionDirectMessage.pattern

      expect(pattern).to eq('@docbot: Array#first')
    end
  end
end
