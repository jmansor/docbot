require "docbot/version"
require 'slack-ruby-client'
require 'docbot/ruby_doc'
require 'docbot/bot'
require 'docbot/config'

# Public: A Slack Bot to allow Slack users to query for Ruby Core/Stdlib
# documentation
module Docbot
  # Public: start Slack Bot server
  #
  # Returns Nothing.
  def self.start
    slack_rtm_client = Slack::RealTime::Client.new
    ruby_doc = Docbot::RubyDoc.new

    bot = Docbot::Bot.new(slack_rtm_client, ruby_doc)
    bot.start
  end
end
