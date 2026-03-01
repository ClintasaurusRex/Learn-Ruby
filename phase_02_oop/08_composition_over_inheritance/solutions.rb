# frozen_string_literal: true

class Engine
  def start
    "engine on"
  end
end

class ElectricMotor
  def start
    "electric on"
  end
end

class Car
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def drive
    "driving: #{engine.start}"
  end
end

class TurboBooster
  def boost
    "turbo boost"
  end
end

class RaceCar
  def initialize(car, booster)
    @car = car
    @booster = booster
  end

  def race
    "#{@car.drive} + #{@booster.boost}"
  end
end

puts "Composition lets us swap engines without changing Car"
puts Car.new(Engine.new).drive
puts Car.new(ElectricMotor.new).drive
puts RaceCar.new(Car.new(Engine.new), TurboBooster.new).race
