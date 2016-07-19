require 'spec_helper'
require 'docbot/ruby_doc'
require 'docbot/bot'
require 'docbot/matchers/direct_message'
require 'docbot/matchers/bot_mention_direct_message'
require 'docbot/matchers/bot_mention_advanced_message'

RSpec.describe Docbot::Bot do
  let (:bot) do
    Docbot::Bot.new
  end

  let (:bot_id) do
    1
  end

  describe '#read' do
    context 'when documentation is found for the specified symbol' do
      it 'should read the message and figure out if there is ruby doc request and return it if found' do
        message = "<@#{bot_id}>: please explain Array#first"

        expect(Docbot::Matchers::BotMentionAdvancedMessage).to receive(:match).once.and_return('Array#first')

        symbol_doc = bot.read(message, bot_id)
      end
    end
  end

  describe '#must_respond?' do
    context 'when there has been a valid request for ruby documentation' do
      it 'should return true' do
        symbol_doc = double
        allow(symbol_doc).to receive(:text).and_return('= Array#first ...')
        allow(symbol_doc).to receive(:success).and_return(true)

        must_respond = bot.must_respond?(symbol_doc)

        expect(must_respond).to be true
      end
    end

    context 'when there has been an invalid request for ruby documentation' do
      it 'should return true' do
        symbol_doc = double
        allow(symbol_doc).to receive(:text).and_return('not found')
        allow(symbol_doc).to receive(:success).and_return(false)

        must_respond = bot.must_respond?(symbol_doc)

        expect(must_respond).to be true
      end
    end

    context 'when the message contained just one word and it didn\'t match any ruby documentation entry' do
      it 'should return true' do
        symbol_doc = double
        allow(symbol_doc).to receive(:text).and_return('not found')
        allow(symbol_doc).to receive(:success).and_return(false)

        must_respond = bot.must_respond?(symbol_doc)

        expect(must_respond).to be true
      end
    end

    context 'when the message didn\'t match any of the message formats accepted by the bot' do
      it 'should return false' do
        symbol_doc = nil
        must_respond = bot.must_respond?(symbol_doc)

        expect(must_respond).to be false
      end
    end
  end

  describe '#respond_ok' do
    it 'should generate the response containing the request ruby' do
      symbol_doc = double
      allow(symbol_doc).to receive(:text).and_return('= Array#first ...')
      allow(symbol_doc).to receive(:success).and_return(true)
      allow(symbol_doc).to receive(:symbol).and_return('Array#first')

      bot_response = bot.respond_ok(symbol_doc)

      expect(bot_response).to eq('= Array#first ...')
    end
  end

  describe '#respond_error' do
    it 'should generate the response indicating no documentation was found for the requested symbol' do
      symbol_doc = double
      allow(symbol_doc).to receive(:text).and_return('Not found')
      allow(symbol_doc).to receive(:success).and_return(false)
      allow(symbol_doc).to receive(:symbol).and_return('Array#first')

      bot_response = bot.respond_error(symbol_doc)

      expect(bot_response).to eq('I\'m sorry, I could not find any documentation for _Array#first_')
    end
  end

  describe '#respond_help' do
    it 'should return a help text for the user to understand how to talk to the bot' do
      bot_help = bot.respond_help

      expect(bot_help).to eq("Hi human, if you need documentation about any Ruby Core/Stdlib class, module or method, you can ask me in this way:\nArray#first\n@docbot: Array#first\n@docbot: please explain Array#first")
    end
  end

  describe '#needs_help?' do
    context 'when the message mentions the bot with no further text' do
      it 'should return true' do
        message = "<@#{bot_id}>"
        needs_help = bot.needs_help?(message, bot_id)

        expect(needs_help).to be true

        message = "<@#{bot_id}>:"
        needs_help = bot.needs_help?(message, bot_id)

        expect(needs_help).to be true
      end
    end

    context 'when the message mentions the bot followed by the word "help"' do
      it 'should return true' do
        message = "<@#{bot_id}>: help"
        needs_help = bot.needs_help?(message, bot_id)

        expect(needs_help).to be true

        message = "<@#{bot_id}>:help"
        needs_help = bot.needs_help?(message, bot_id)

        expect(needs_help).to be true
      end
    end

    context 'when the message mentions the bot but doesn\t match any of the help patterns' do
      it 'should return false' do
        message = "<@#{bot_id}>: help me"
        needs_help = bot.needs_help?(message, bot_id)

        expect(needs_help).to be false
      end
    end
  end
end
