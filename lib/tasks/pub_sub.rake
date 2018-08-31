task verbose: [:environment] do
  Rails.logger = Logger.new(STDOUT)
end

namespace :pub_sub do
  desc "Listen to Google pub/sub subscriptions to perform jobs"
  task listen_to_subscriptions: :environment do
    #available job classes whitelist
    available_jobs = ['TestJob']
    worker = SubWorker.new

    worker.perform do |message_data|
      klass_name = JSON.parse(message_data)['job']
      return if !available_jobs.include? klass_name

      klass = Object.const_get(klass_name)
      klass.perform_now message_data
    end
  end

end
