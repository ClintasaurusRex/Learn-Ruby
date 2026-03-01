# frozen_string_literal: true

# Exercise 1 solution:
# OOP exists to keep related data and behavior in one place.
def oop_reason
  "OOP keeps related state and behavior together."
end

# Exercise 2 solution:
# This reinforces class (blueprint) vs object (instance).
def class_object_pair
  "Class: User | Object: ava"
end

# Exercise 3 solution:
# A simple predicate returns true/false based on state.
def active_status?(status)
  status == "active"
end

# Exercise 4 solution:
# We label one piece of state and one behavior example.
def state_and_behavior_labels
  ["state:name", "behavior:active?"]
end

# Exercise 5 solution:
# Build a formatted name using interpolation and upcase.
def format_user_name(name)
  "User<#{name.upcase}>"
end

puts oop_reason
puts class_object_pair
puts active_status?("active")
p state_and_behavior_labels
puts format_user_name("ava")
