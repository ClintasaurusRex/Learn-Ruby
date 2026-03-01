# frozen_string_literal: true

class Animal
  def speak
    "sound"
  end
end

class Dog < Animal
  # TODO: override speak and call super
  # Hint: "#{super} bark"
  def speak
    super
  end
end

animal = Animal.new
dog = Dog.new
puts animal.speak
puts dog.speak
