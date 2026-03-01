# frozen_string_literal: true

# Exercise 1 solution
def present?(value)
  !value.nil? && !value.to_s.strip.empty?
end

# Exercise 2 solution
def valid_email_format?(email)
  email.include?('@')
end

# Exercise 3 solution
def validation_errors(email)
  errors = []
  errors << "Email can't be blank" unless present?(email)
  errors << 'Email format is invalid' unless valid_email_format?(email)
  errors
end

# Exercise 4 solution
def save_result(email)
  errors = validation_errors(email)
  { saved: errors.empty?, errors: errors }
end

# Exercise 5 solution
def bubble_up_errors(errors)
  errors.join(' | ')
end

p present?('hello')
p valid_email_format?('a@b.com')
p validation_errors('')
p save_result('bad-email')
puts bubble_up_errors(["Email can't be blank", 'Email format is invalid'])
