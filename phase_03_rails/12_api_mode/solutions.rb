# frozen_string_literal: true

require 'json'

# Exercise 1 solution
def serialize_user(user)
  { id: user[:id], name: user[:name] }
end

# Exercise 2 solution
def json_body(hash)
  JSON.generate(hash)
end

# Exercise 3 solution
def success_response(resource_hash)
  { status: 200, body: json_body(resource_hash) }
end

# Exercise 4 solution
def error_response(errors)
  { status: 422, body: json_body(errors: errors) }
end

# Exercise 5 solution
def request_id(headers)
  headers['X-Request-Id']
end

p serialize_user(id: 1, name: 'Ari', admin: false)
puts json_body(id: 1, name: 'Ari')
p success_response(id: 1, name: 'Ari')
p error_response(['name is required'])
puts request_id('X-Request-Id' => 'req-123')
