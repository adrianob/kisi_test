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

    def default_topic
      @default_topic ||= Rails.configuration.x.settings['default_topic']
    end

    def default_subscription
      @default_subscription ||= Rails.configuration.x.settings['default_subscription']
    end
  end
end
