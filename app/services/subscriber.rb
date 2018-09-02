# Google Pub/Sub subscriber
# Receives messages from one or more subscriptions
class Subscriber

  DEFAULT_SUB = "#{PubSubConnection.default_topic}.#{PubSubConnection.default_subscription}"
  attr_reader :subscriptions
  attr_accessor :messages

  # subscriptions must be a string in the format 'topic.subscription'
  def initialize(subscriptions = [DEFAULT_SUB])
    @subscriptions = subscriptions
    @messages = []
  end
end
