# Docbot

Docbot is a Slack Bot that allows users to ask for Ruby Core/Stdlib documentation by talking to the Bot.

## Installation

First you will need to install all the bot dependencies:

```bash
script/setup
```

### Dependencies
This project depends on [slack-ruby-client](https://github.com/dblock/slack-ruby-client), a gem that handles the connection to the Slack RTM API and provides a set of mechanisms to bind the Slack and respond to them.

## Usage

To start the bot, run:

```bash
SLACK_API_TOKEN=<your-slack-bot-token> script/server
```

### How do I talk to the bot?
There are three ways to ask the bot for Ruby documentation:

#### Direct Message
Send a message with just the class, module or method you want to know about
```
Array#first
```

#### Bot Mention Direct Message
Send a message with a mention to the Bot, followed by the class, module or method you want to know about.
```
@<your-bot-name>: Array#first
```

#### Bot Mention Advanced Message
Send a message with a mention to the Bot, followed by 'please explain', followed by the class, module or method you want to know about.
```
@<your-bot-name>: please explain Array#first
```

### Don't want to have to remember all this?
You can ask the Bot how to talk to him:
```
@<your-bot-name>
```
or
```
@<your-bot-name>: help
```

### What are the accepted formats to indicate the Ruby class, module or method I want to know about?

```
Class | Module | Module::Class | Class::method | Class#method | Class.method | method
```

#### Examples
```
@<your-bot-name>: please explain Array#first
@<your-bot-name>: rand
Array.first
@<your-bot-name>: ACL::ACLEntry
```
## Test

To run the project tests, run:
```
script/test
```

## Have Docker?
This project includes a Dockerfile to create a Docker image where you can setup
the project to run.

First create the image:
```
$ docker build -t docbot -f Dockerfile .
```

Then, create a container from the image:
```
$ docker run -it docbot bash --login
```

In the container terminal, clone the project and run the setup script
```
docker-container$ git clone https://github.com/jmansor/docbot.git
docker-container$ cd docbot
docker-container$ script/setup
docker-container$ SLACK_API_TOKEN=<your-slack-bot-token> script/server
```
