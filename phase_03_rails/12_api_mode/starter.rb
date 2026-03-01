# frozen_string_literal: true

require 'json'

def serialize_user(user)
  # TODO: return hash with id/name keys
end

user = { id: 1, name: 'Ari' }
body = JSON.generate(serialize_user(user))
puts "Body: #{body}"
