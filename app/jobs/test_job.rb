class ExampleService
  def self.call(*args)
    true
  end
end

class TestJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.minutes, attempts: 2, queue: :default

  def perform(*args)
    Rails.logger.info "Started test job with args " +
                      "#{args}"
    ExampleService.call 123
  end
end
