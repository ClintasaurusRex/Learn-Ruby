# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 08: Composition Over Inheritance" do
  it "car delegates drive to engine" do
    expect(Car.new(Engine.new).drive).to eq("driving: engine on")
  end

  it "car can swap in electric motor" do
    expect(Car.new(ElectricMotor.new).drive).to eq("driving: electric on")
  end

  it "race car composes extra behavior" do
    race_car = RaceCar.new(Car.new(Engine.new), TurboBooster.new)
    expect(race_car.race).to eq("driving: engine on + turbo boost")
  end

  it "engine and motor share same contract" do
    expect(Engine.new).to respond_to(:start)
    expect(ElectricMotor.new).to respond_to(:start)
  end

  it "retains injected engine for inspection" do
    engine = Engine.new
    expect(Car.new(engine).engine).to equal(engine)
  end
end
