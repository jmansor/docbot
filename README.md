# Docbot

Docbot is a Slack Bot that allows users to ask for Ruby Core/Stdlib documentation by talking to the Bot.

## Installation

First you will need to install all the bot dependencies:

```bash
script/setup
```

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
