require "google/cloud/pubsub"

# Listen to subscription messages and forward them to the passed block
class SubWorker
  def perform(*args)
    Rails.logger.info "Running test worker with args #{args}"
    topic        = PubSubConnection.pubsub.topic PubSubConnection.pubsub_topic
    subscription = topic.subscription PubSubConnection.pubsub_subscription

    subscriber = subscription.listen do |message|
      message.acknowledge!

      Rails.logger.info "Listened to message with data: (#{message.data})"

      yield message.data
    end

    # Start background threads that will call block passed to listen.
    subscriber.start

    # Fade into a deep sleep as worker will run indefinitely
    sleep
  end
end
