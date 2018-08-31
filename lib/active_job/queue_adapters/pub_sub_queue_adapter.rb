require "google/cloud/pubsub"

# Google pub/sub adapter
# Publish the received job arguments to a topic
module ActiveJob
  module QueueAdapters
    class PubSubQueueAdapter

       def pubsub
        @pubsub ||= begin
          project_id = Rails.application.config.x.settings['project_id']
          Google::Cloud::Pubsub.new(
            project_id: project_id,
            credentials: Rails.application.config.x.settings['pubsub_credentials_path']
          )
        end
      end

      def pubsub_topic
        @pubsub_topic ||= Rails.configuration.x.settings['pubsub_topic']
      end

      def pubsub_subscription
        @pubsub_subscription ||= Rails.configuration.x.settings['pubsub_subscription']
      end

      def enqueue job
        Rails.logger.info "[PubSubQueueAdapter] enqueue job #{job.inspect}"

        message = job.arguments.first.to_json
        topic   = pubsub.topic pubsub_topic

        topic.publish message
      end
    end
  end
end
