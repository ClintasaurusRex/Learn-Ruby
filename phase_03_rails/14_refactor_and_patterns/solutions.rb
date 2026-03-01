# frozen_string_literal: true

# Exercise 1 solution
def choose_pattern(need)
  case need
  when :orchestration
    :service_object
  when :shared_model_behavior
    :concern
  when :presentation_formatting
    :decorator
  else
    :inline
  end
end

# Exercise 2 solution
def charge_message(total_cents)
  "Charged order total: #{total_cents}"
end

# Exercise 3 solution
def notifier(message)
  "Notify: #{message}"
end

# Exercise 4 solution
def formatted_total(total_cents)
  format('$%.2f', total_cents / 100.0)
end

# Exercise 5 solution
def refactor_summary
  'Refactor by extracting orchestration to service objects, shared behavior to concerns, and formatting to decorators.'
end

puts choose_pattern(:orchestration)
puts charge_message(2599)
puts notifier('order charged')
puts formatted_total(2599)
puts refactor_summary
