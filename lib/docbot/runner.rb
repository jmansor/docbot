require 'slack-ruby-client'
require 'docbot/bot'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

module Docbot
  class Runner
    def self.run
      slack_rtm_client = Slack::RealTime::Client.new
      ruby_doc = Docbot::RubyDoc.new

      bot = Docbot::Bot.new(slack_rtm_client, ruby_doc)
      bot.start
    end
  end
end
