# frozen_string_literal: true

require 'rspec'
require_relative ENV.fetch('LESSON_FILE', 'exercises')

RSpec.describe 'Lesson 12: API Mode' do
  it 'serializes exposed user fields' do
    expect(serialize_user(id: 1, name: 'Ari', admin: true)).to eq(id: 1, name: 'Ari')
  end

  it 'generates JSON body' do
    expect(json_body(id: 1, name: 'Ari')).to eq('{"id":1,"name":"Ari"}')
  end

  it 'builds success response' do
    expect(success_response(id: 1, name: 'Ari')).to eq(status: 200, body: '{"id":1,"name":"Ari"}')
  end

  it 'builds error response' do
    expect(error_response(['name is required'])).to eq(status: 422, body: '{"errors":["name is required"]}')
  end

  it 'extracts request id from headers' do
    expect(request_id('X-Request-Id' => 'req-123')).to eq('req-123')
  end
end
