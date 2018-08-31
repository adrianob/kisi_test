class PubSubConnection
  class << self
    def pubsub
       @pubsub ||= begin
         project_id = Rails.application.config.x.settings['project_id']
         Google::Cloud::Pubsub.new(
           project_id: project_id,
           credentials: Rails.application.config.x.settings['pubsub_credentials_path']
         )
       end
    end

    def pubsub_topic(topic = nil)
      @pubsub_topic ||= topic || Rails.configuration.x.settings['pubsub_topic']
    end

    def pubsub_subscription(subscription = nil)
      @pubsub_subscription ||= subscription || Rails.configuration.x.settings['pubsub_subscription']
    end
  end
end
