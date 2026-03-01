# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 14: Refactor and Patterns' do
  it 'chooses pattern by need' do
    expect(choose_pattern(:orchestration)).to eq(:service_object)
    expect(choose_pattern(:shared_model_behavior)).to eq(:concern)
    expect(choose_pattern(:presentation_formatting)).to eq(:decorator)
  end

  it 'formats charge message' do
    expect(charge_message(2599)).to eq('Charged order total: 2599')
  end

  it 'formats notifier output' do
    expect(notifier('order charged')).to eq('Notify: order charged')
  end

  it 'formats decorated total' do
    expect(formatted_total(2599)).to eq('$25.99')
  end

  it 'summarizes refactor patterns' do
    summary = refactor_summary
    expect(summary).to include('service objects')
    expect(summary).to include('concerns')
    expect(summary).to include('decorators')
  end
end
