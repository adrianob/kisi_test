require 'spec_helper'

RSpec.describe TestJob do
  include ActiveJob::TestHelper
  subject(:job) { described_class.perform_later(key) }

  let(:key) { 123 }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class)
      .with(key)
      .on_queue("default")
  end

  it 'handles exception' do
    allow(ExampleService).to receive(:call).and_raise(StandardError)

    perform_enqueued_jobs do
      expect_any_instance_of(described_class)
        .to receive(:retry_job).with(wait: 300, queue: :default, priority: nil)

      job
    end
  end

  it 'executes perform' do
    expect(ExampleService).to receive(:call).with(123)
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
