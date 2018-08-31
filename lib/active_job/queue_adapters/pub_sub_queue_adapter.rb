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

        topic.publish message.to_json
      end
    end
  end
end
