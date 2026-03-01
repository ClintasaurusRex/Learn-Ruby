# frozen_string_literal: true

# Exercise 1 solution
def digest_password(raw)
  "digest::#{raw.reverse}"
end

# Exercise 2 solution
def authenticated?(password_digest, password_attempt)
  digest_password(password_attempt) == password_digest
end

# Exercise 3 solution
def login_result(stored_email, input_email, password_digest, input_password)
  stored_email == input_email && authenticated?(password_digest, input_password)
end

# Exercise 4 solution
def session_payload(login_ok, email)
  login_ok ? { current_user_email: email } : {}
end

# Exercise 5 solution
def plain_text_password_risk
  'Plain text passwords expose every account if storage leaks.'
end

p digest_password('secret123')
p authenticated?(digest_password('secret123'), 'secret123')
p login_result('learner@example.com', 'learner@example.com', digest_password('secret123'), 'secret123')
p session_payload(true, 'learner@example.com')
puts plain_text_password_risk
