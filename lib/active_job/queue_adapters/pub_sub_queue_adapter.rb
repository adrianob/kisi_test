require "google/cloud/pubsub"

# Google pub/sub adapter
# Publish the received job arguments to a topic
module ActiveJob
  module QueueAdapters
    class PubSubQueueAdapter

      # job argument must be in this format: message, job_name, topics array
      def enqueue job
        Rails.logger.info "[PubSubQueueAdapter] enqueue job #{job.inspect}"

        message, job_name, topics = job.arguments
        publisher = Publisher.new(message, job_name, topics)

        publisher.publish_to_topics
      end
    end
  end
end
