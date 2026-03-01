# frozen_string_literal: true

# Exercise 1 solution:
# Polymorphism sends one method name to many object types.
def polymorphism_phrase
  "same message, different behavior"
end

# Exercise 2 solution:
# In Ruby, we care that an object responds to the method (duck typing).
def renderable?(object)
  object.respond_to?(:render)
end

# Exercise 3 solution:
# Text-specific implementation output.
def text_render
  "TEXT: hello"
end

# Exercise 4 solution:
# Email-specific implementation output.
def email_render
  "EMAIL: hello"
end

# Exercise 5 solution:
# One caller can ask each object for the same message: render.
def collect_renders(renderables)
  renderables.map(&:render)
end

TextMessage = Struct.new(:value) do
  def render
    "TEXT: #{value}"
  end
end

EmailMessage = Struct.new(:value) do
  def render
    "EMAIL: #{value}"
  end
end

puts polymorphism_phrase
puts renderable?(TextMessage.new("hello"))
puts text_render
puts email_render
p collect_renders([TextMessage.new("hello"), EmailMessage.new("hello")])
