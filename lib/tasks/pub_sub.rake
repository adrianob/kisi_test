task verbose: [:environment] do
  Rails.logger = Logger.new(STDOUT)
end

namespace :pub_sub do
  desc "Listen to Google pub/sub subscriptions to perform jobs"
  task listen_to_subscriptions: :environment do
    worker = SubWorker.new
    worker.perform do |message_data|
      TestJob.perform_now message_data
    end
    #add more jobs below
  end

end
