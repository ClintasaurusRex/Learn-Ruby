# frozen_string_literal: true

class Car
  attr_reader :brand, :year

  def initialize(brand, year)
    @brand = brand
    @year = year
  end

  def describe
    "Car(#{brand}, #{year})"
  end
end

car_a = Car.new("Ford", 2020)
car_b = Car.new("Tesla", 2024)

puts car_a.describe
puts car_b.describe
puts "Same class? #{car_a.class == car_b.class}"
puts "Same object? #{car_a.equal?(car_b)}"
