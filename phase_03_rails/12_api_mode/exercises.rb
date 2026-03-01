# frozen_string_literal: true

# Exercise 1: serialize only exposed user fields.
def serialize_user(user)
  # TODO: return { id: ..., name: ... }
end

# Exercise 2: build JSON body from hash.
def json_body(hash)
  # TODO: JSON.generate(hash)
end

# Exercise 3: standard success payload.
def success_response(resource_hash)
  # TODO: { status: 200, body: ... }
end

# Exercise 4: standard error payload.
def error_response(errors)
  # TODO: { status: 422, body: ... }
end

# Exercise 5: extract request id from headers.
def request_id(headers)
  # TODO: return headers['X-Request-Id']
end
