# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 11: Background Jobs' do
  it 'marks slow tasks as background candidates' do
    expect(background_job_candidate?(duration_ms: 500)).to be(true)
    expect(background_job_candidate?(duration_ms: 100)).to be(false)
  end

  it 'enqueues jobs' do
    queue = []
    expect(enqueue(queue, 'send_email')).to eq(['send_email'])
  end

  it 'dequeues jobs in FIFO order' do
    queue = ['first', 'second']
    expect(dequeue(queue)).to eq('first')
    expect(queue).to eq(['second'])
  end

  it 'formats worker messages' do
    expect(worker_message('send_email')).to eq('Processed: send_email')
  end

  it 'returns common job examples' do
    expect(common_job_examples).to eq(['send_email', 'generate_report', 'sync_webhook'])
  end
end
