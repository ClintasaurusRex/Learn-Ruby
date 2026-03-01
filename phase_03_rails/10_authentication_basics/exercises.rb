# frozen_string_literal: true

# Exercise 1: simulate digest.
def digest_password(raw)
  # TODO: return "digest::<reversed password>"
end

# Exercise 2: verify password attempt.
def authenticated?(password_digest, password_attempt)
  # TODO: compare with digest_password(password_attempt)
end

# Exercise 3: perform login flow.
def login_result(stored_email, input_email, password_digest, input_password)
  # TODO: return true only when email and password both match
end

# Exercise 4: create session hash on success.
def session_payload(login_ok, email)
  # TODO: { current_user_email: email } or {}
end

# Exercise 5: security explanation string.
def plain_text_password_risk
  # TODO: return one sentence risk summary
end
