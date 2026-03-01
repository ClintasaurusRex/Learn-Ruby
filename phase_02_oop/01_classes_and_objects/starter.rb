# frozen_string_literal: true

class Car
  attr_reader :brand

  def initialize(brand)
    @brand = brand
  end

  # TODO: return a formatted description
  # Hint: "Car(#{brand})"
  def describe
    "Car(unknown)"
  end
end

car_a = Car.new("Ford")
car_b = Car.new("Tesla")

puts car_a.describe
puts car_b.describe
puts "Same class? #{car_a.class == car_b.class}"
puts "Same object? #{car_a.equal?(car_b)}"
