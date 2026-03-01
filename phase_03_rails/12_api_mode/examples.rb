# frozen_string_literal: true

require 'json'

def serialize_user(user)
  {
    id: user[:id],
    name: user[:name]
  }
end

def build_response(user)
  {
    status: 200,
    body: JSON.generate(serialize_user(user))
  }
end

user = { id: 1, name: 'Ari', admin: false }
response = build_response(user)

puts "Status: #{response[:status]}"
puts "Body: #{response[:body]}"
