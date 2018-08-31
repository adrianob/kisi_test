require "google/cloud/pubsub"

# Google pub/sub adapter
# Publish the received job arguments to a topic
module ActiveJob
  module QueueAdapters
    class PubSubQueueAdapter
      def enqueue job
        Rails.logger.info "[PubSubQueueAdapter] enqueue job #{job.inspect}"

        message = job.arguments.first.to_json
        topic   = PubSubConnection.pubsub.topic PubSubConnection.pubsub_topic

        topic.publish message
      end
    end
  end
end
