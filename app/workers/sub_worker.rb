require "google/cloud/pubsub"

# Listen to subscription messages and forward them to the passed block
class SubWorker
  def perform(subscriptions)
    Rails.logger.info "Running test worker with subscriptions #{subscriptions}"
    connection = PubSubConnection.pubsub

    subscriptions.each do |sub|
      topic_name, subscription_name = sub.split '.'
      topic        = connection.topic topic_name
      subscription = topic.subscription subscription_name

      subscriber = subscription.listen do |message|
        message.acknowledge!

        Rails.logger.info "Listened to message with data: (#{message.data}) on subscription #{sub}"

        yield message.data
      end

      # Start background threads that will call block passed to listen.
      subscriber.start
    end
    # Fade into a deep sleep as worker will run indefinitely
    sleep
  end
end
