task verbose: [:environment] do
  Rails.logger = Logger.new(STDOUT)
end

namespace :pub_sub do
  desc "Listen to Google pub/sub subscriptions to perform jobs"
  task listen_to_subscriptions: :environment do
    #available job classes whitelist
    available_jobs = ['TestJob']
    # example of using multiple subscribers
    # subscriber = Subscriber.new(['testTopic.testSubscription', 'secondTopic.secondSubscription'])

    subscriber = Subscriber.new
    worker = SubWorker.new

    worker.perform(subscriber.subscriptions) do |message_data|
      parsed_message = JSON.parse(message_data)
      subscriber.messages << parsed_message
      klass_name = parsed_message['job']
      return unless available_jobs.include? klass_name

      job_klass = Object.const_get(klass_name)
      job_klass.perform_now parsed_message['message']
    end
  end

end
