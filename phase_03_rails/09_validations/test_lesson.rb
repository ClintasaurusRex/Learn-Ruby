# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 09: Validations' do
  it 'checks presence' do
    expect(present?('x')).to be(true)
    expect(present?('   ')).to be(false)
    expect(present?(nil)).to be(false)
  end

  it 'checks email format' do
    expect(valid_email_format?('a@b.com')).to be(true)
    expect(valid_email_format?('a-at-b.com')).to be(false)
  end

  it 'collects validation errors' do
    expect(validation_errors('')).to include("Email can't be blank")
    expect(validation_errors('invalid')).to include('Email format is invalid')
  end

  it 'returns save result payload' do
    expect(save_result('a@b.com')).to eq(saved: true, errors: [])
    expect(save_result('bad')[:saved]).to be(false)
  end

  it 'formats errors for bubble-up display' do
    errors = ["Email can't be blank", 'Email format is invalid']
    expect(bubble_up_errors(errors)).to eq("Email can't be blank | Email format is invalid")
  end
end
