# frozen_string_literal: true

# Exercise 1 solution:
# Counter.total_created is invoked on the class, so it is class-level.
def method_type_for_counter_total
  "class method"
end

# Exercise 2 solution:
# label belongs to each object, so it is instance-level.
def method_type_for_label
  "instance method"
end

# Exercise 3 solution:
# Simple instance-style label formatter.
def format_counter_label(name)
  "Counter<#{name}>"
end

# Exercise 4 solution:
# Shared counters often increment with +1.
def increment_total(total)
  total + 1
end

# Exercise 5 solution:
# A class receiver is represented by "Class" in this exercise.
def class_receiver?(receiver_type)
  receiver_type == "Class"
end

puts method_type_for_counter_total
puts method_type_for_label
puts format_counter_label("A")
puts increment_total(2)
puts class_receiver?("Class")
