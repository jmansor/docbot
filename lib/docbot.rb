require "docbot/version"
require 'slack-ruby-client'
require 'docbot/ruby_doc'
require 'docbot/bot'
require 'docbot/config'

module Docbot
  def self.start
    slack_rtm_client = Slack::RealTime::Client.new
    ruby_doc = Docbot::RubyDoc.new

    bot = Docbot::Bot.new(slack_rtm_client, ruby_doc)
    bot.start
  end
end
