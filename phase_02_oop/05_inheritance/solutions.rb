# frozen_string_literal: true

# Exercise 1 solution:
# Subclasses are declared with the < operator.
def inheritance_operator
  "<"
end

# Exercise 2 solution:
# Dog is a subtype of Animal in this lesson model.
def dog_is_animal?
  true
end

# Exercise 3 solution:
# Base class provides the shared default sound.
def base_sound
  "sound"
end

# Exercise 4 solution:
# Child output uses parent output plus dog-specific suffix.
def dog_sound
  "#{base_sound} bark"
end

# Exercise 5 solution:
# Another child output based on the same shared base.
def cat_sound
  "#{base_sound} meow"
end

puts inheritance_operator
puts dog_is_animal?
puts base_sound
puts dog_sound
puts cat_sound
