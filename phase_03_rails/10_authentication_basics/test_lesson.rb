# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 10: Authentication Basics' do
  it 'digests passwords deterministically' do
    expect(digest_password('secret123')).to eq('digest::321terces')
  end

  it 'authenticates using digest comparison' do
    digest = digest_password('secret123')
    expect(authenticated?(digest, 'secret123')).to be(true)
    expect(authenticated?(digest, 'wrong')).to be(false)
  end

  it 'returns login result by email and password' do
    digest = digest_password('secret123')
    expect(login_result('a@b.com', 'a@b.com', digest, 'secret123')).to be(true)
    expect(login_result('a@b.com', 'x@y.com', digest, 'secret123')).to be(false)
  end

  it 'builds session payload' do
    expect(session_payload(true, 'a@b.com')).to eq(current_user_email: 'a@b.com')
    expect(session_payload(false, 'a@b.com')).to eq({})
  end

  it 'explains plain text password risk' do
    expect(plain_text_password_risk).to include('passwords')
  end
end
