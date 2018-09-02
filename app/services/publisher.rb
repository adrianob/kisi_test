# Google Pub/Sub Publisher
# Sends message to one or more topics

class TopicNotFound < RuntimeError
end

class Publisher

  attr_reader :topics, :job
  attr_accessor :message
  def initialize(message, job, topics = [PubSubConnection.default_topic])
    @job = job
    @message = message
    @topics = topics
  end

  def publish_to_topics
    @topics.each do |topic_name|
      connection = PubSubConnection.pubsub

      message = {job: @job, message: @message}
      begin
        topic   = connection.topic topic_name
        raise TopicNotFound unless topic

        topic.publish_async message.to_json
        topic.async_publisher.stop.wait!
      rescue
        Rails.logger.info "Couldn't publish to topic #{topic_name}"
      end
    end
  end
end
