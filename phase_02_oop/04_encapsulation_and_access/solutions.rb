# frozen_string_literal: true

# Exercise 1 solution:
# Validator helpers are usually private implementation details.
def validator_visibility
  "private"
end

# Exercise 2 solution:
# Positive check protects against invalid balance updates.
def positive_amount?(amount)
  amount > 0
end

# Exercise 3 solution:
# Private methods are not callable directly from outside.
def can_call_private_directly?
  false
end

# Exercise 4 solution:
# Public API is the external interface of an object.
def safe_entry_point
  "public API"
end

# Exercise 5 solution:
# Display helper for user-facing balance output.
def balance_label(amount)
  "Balance: #{amount}"
end

puts validator_visibility
puts positive_amount?(10)
puts can_call_private_directly?
puts safe_entry_point
puts balance_label(30)
