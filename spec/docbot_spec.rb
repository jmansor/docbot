require 'spec_helper'
require 'docbot'

RSpec.describe Docbot do
  describe '#start' do
    it 'should instance the bot and start it' do
      bot = instance_double('Docbot::Bot')
      expect(bot).to receive(:start)
      expect(Docbot::Bot).to receive(:new).and_return(bot)

      Docbot.start
    end
  end
end
