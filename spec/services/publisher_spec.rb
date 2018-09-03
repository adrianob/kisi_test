require 'spec_helper'

RSpec.describe Publisher do

  let(:publish) { TestJob.perform_later('Hello, World!', ['firstTopic', 'secondTopic']) }

  before do
    expect_any_instance_of(Publisher).to receive(:publish_to_topics)
  end

  it('should satisfy expectations') { publish }

end
