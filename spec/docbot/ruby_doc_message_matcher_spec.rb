require 'spec_helper'
require 'docbot/ruby_doc'
require 'docbot/ruby_doc_message_matcher'
require 'docbot/matchers/direct_message'
require 'docbot/matchers/bot_mention_direct_message'
require 'docbot/matchers/bot_mention_advanced_message'

RSpec.describe Docbot::RubyDocMessageMatcher do
  describe '#parse' do
    context 'when documentation is found for the specified symbol' do
      it 'should call bot mention advanced matcher and return the symbol candidate' do
        bot_id = '1'
        message = "<@#{bot_id}>: please explain Array#first"

        expect(Docbot::Matchers::BotMentionAdvancedMessage).to receive(:match).once.and_return('Array#first')

        ruby_doc = Docbot::RubyDoc.new
        ruby_doc_message_matcher = Docbot::RubyDocMessageMatcher.new(ruby_doc)
        symbol_doc = ruby_doc_message_matcher.parse(message, bot_id)
      end
    end
  end
end
