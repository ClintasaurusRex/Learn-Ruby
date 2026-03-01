# frozen_string_literal: true

# Exercise 1: return true when value is present.
def present?(value)
  # TODO: return false for nil or blank strings
end

# Exercise 2: return true when email includes @.
def valid_email_format?(email)
  # TODO: simple email format check
end

# Exercise 3: collect validation errors.
def validation_errors(email)
  # TODO: add "Email can't be blank" and/or "Email format is invalid"
end

# Exercise 4: return result hash for save attempt.
def save_result(email)
  # TODO: { saved: true/false, errors: [...] }
end

# Exercise 5: format errors for UI bubble-up.
def bubble_up_errors(errors)
  # TODO: join errors with " | "
end
