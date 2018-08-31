class ExampleService
  def self.call(*args)
    true
  end
end

class TestJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.minutes, attempts: 3, queue: :default

  def perform(*args)
    if executions == 3
      Rails.logger.info "Final try, moving to morgue queue"
      retry_job wait: 0, queue: :morgue
      return nil
    end

    Rails.logger.info "Started test job with args " +
                      "#{args}"
    ExampleService.call 123
  end
end
