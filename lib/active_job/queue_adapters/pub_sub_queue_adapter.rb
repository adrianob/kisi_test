require "google/cloud/pubsub"

# Google pub/sub adapter
# Publish the received job arguments to a topic
module ActiveJob
  module QueueAdapters
    class PubSubQueueAdapter

      # job argument must be a hash with a 'job' key
      def enqueue job
        Rails.logger.info "[PubSubQueueAdapter] enqueue job #{job.inspect}"

        message, = job.arguments
        topic   = PubSubConnection.pubsub.topic PubSubConnection.pubsub_topic

        topic.publish_async message.to_json
        topic.async_publisher.stop.wait!
      end
    end
  end
end
