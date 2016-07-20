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

        message = "<@#{bot_id}>:please explain Array#first"
        symbol = Docbot::Matchers::BotMentionAdvancedMessage.match(message, bot_id)
        expect(symbol).to eq('Array#first')

        message = "<@#{bot_id}>: please explain Array"
        symbol = Docbot::Matchers::BotMentionAdvancedMessage.match(message, bot_id)
        expect(symbol).to eq('Array')

        message = "<@#{bot_id}>: please explain Array.first"
        symbol = Docbot::Matchers::BotMentionAdvancedMessage.match(message, bot_id)
        expect(symbol).to eq('Array.first')

        message = "<@#{bot_id}>: please explain ACL::ACLEntry"
        symbol = Docbot::Matchers::BotMentionAdvancedMessage.match(message, bot_id)
        expect(symbol).to eq('ACL::ACLEntry')

        message = "<@#{bot_id}>: please explain Array#first to me bot"
        symbol = Docbot::Matchers::BotMentionAdvancedMessage.match(message, bot_id)
        expect(symbol).to be_nil
      end
    end
  end

  describe '#pattern' do
    it 'should return the message pattern matched by the matcher' do
      bot_id = '1'
      pattern = Docbot::Matchers::BotMentionAdvancedMessage.pattern(bot_id)

      expect(pattern).to eq(/\A<@#{bot_id}>:{0,1}\s*please\s+explain (?<symbol>\S+)$/)
    end
  end

  describe '#pattern_example' do
    it 'should return a pattern example matched by the matcher' do
      bot_name = 'rubydocbot'
      pattern = Docbot::Matchers::BotMentionAdvancedMessage.pattern_example(bot_name)

      expect(pattern).to eq("@#{bot_name}: please explain Array#first")
    end
  end
end
