# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 13: Testing with RSpec' do
  it 'checks model-level order total' do
    expect(valid_order_total?(10, 1)).to be(true)
    expect(valid_order_total?(-10, 1)).to be(false)
  end

  it 'checks request contract shape' do
    expect(request_contract_ok?(200, data: { id: 1 })).to be(true)
    expect(request_contract_ok?(500, data: { id: 1 })).to be(false)
  end

  it 'returns system scenarios' do
    expect(system_scenarios.length).to be >= 2
  end

  it 'returns test pyramid layers' do
    expect(test_pyramid_layers).to eq(['model', 'request', 'system'])
  end

  it 'selects preferred test level' do
    expect(preferred_test_level(:pure_logic)).to eq(:model)
    expect(preferred_test_level(:endpoint_contract)).to eq(:request)
    expect(preferred_test_level(:ui_flow)).to eq(:system)
  end
end
