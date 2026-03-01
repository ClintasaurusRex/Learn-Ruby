# frozen_string_literal: true

class Car
end

# Exercise 1 solution: names the class from the lesson.
def lesson_class_name
  "Car"
end

# Exercise 2 solution: confirms object creation language.
def object_created_label
  "Object created: Car"
end

# Exercise 3 solution: both inputs must be Car objects.
def both_cars?(first, second)
  first.is_a?(Car) && second.is_a?(Car)
end

# Exercise 4 solution: equal? checks object identity.
def same_object?(first, second)
  first.equal?(second)
end

# Exercise 5 solution: builds a display string from brand.
def format_car(brand)
  "Car(#{brand})"
end

car_a = Car.new
car_b = Car.new
puts lesson_class_name
puts object_created_label
puts both_cars?(car_a, car_b)
puts same_object?(car_a, car_b)
puts format_car("Ford")
