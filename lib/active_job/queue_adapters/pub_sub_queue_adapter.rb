require "google/cloud/pubsub"

# Google pub/sub adapter
# Publish the received job arguments to a topic
module ActiveJob
  module QueueAdapters
    class PubSubQueueAdapter

      # job argument must be in this format: message, topics array
      def enqueue job
        Rails.logger.info "[PubSubQueueAdapter] enqueue job #{job.inspect}"

        message, topics = job.arguments
        job_name = job.class.to_s
        publisher = Publisher.new(message, job_name, topics)

        publisher.publish_to_topics
      end
    end
  end
end
