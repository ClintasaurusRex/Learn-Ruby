# frozen_string_literal: true

# Exercise 1: Build an Engine object with #start.
class Engine
  def start
    "TODO"
  end
end

# Exercise 2: Build an ElectricMotor with the same interface.
class ElectricMotor
  def start
    "TODO"
  end
end

# Exercise 3: Compose Car with an injected engine.
class Car
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def drive
    # TODO: delegate to engine.start
    "TODO"
  end
end

# Exercise 4: Compose race behavior instead of inheriting from Engine.
class TurboBooster
  def boost
    "TODO"
  end
end

# Exercise 5: Build RaceCar by composing Car + TurboBooster.
class RaceCar
  def initialize(car, booster)
    @car = car
    @booster = booster
  end

  def race
    "TODO"
  end
end
