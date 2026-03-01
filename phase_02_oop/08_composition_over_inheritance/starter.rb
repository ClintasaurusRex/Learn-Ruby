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
    # TODO: delegate to engine.start
    # Hint: interpolation helps make output readable
    "driving: #{engine.start}"
  end
end

puts Car.new(Engine.new).drive
puts Car.new(ElectricMotor.new).drive
