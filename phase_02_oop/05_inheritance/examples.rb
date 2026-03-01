# frozen_string_literal: true

class Animal
  def speak
    "sound"
  end
end

class Dog < Animal
  def speak
    "#{super} bark"
  end
end

class Cat < Animal
  def speak
    "#{super} meow"
  end
end

puts Animal.new.speak
puts Dog.new.speak
puts Cat.new.speak
puts Dog.ancestors.take(3).join(" < ")
