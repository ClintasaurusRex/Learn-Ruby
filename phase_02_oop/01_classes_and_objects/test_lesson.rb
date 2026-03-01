# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

class Car; end unless defined?(Car)

RSpec.describe "Lesson 01: Classes and Objects" do
  it "returns class name" do
    expect(lesson_class_name).to eq("Car")
  end

  it "returns object created label" do
    expect(object_created_label).to eq("Object created: Car")
  end

  it "detects two car instances" do
    expect(both_cars?(Car.new, Car.new)).to be(true)
  end

  it "checks object identity" do
    car = Car.new
    expect(same_object?(car, car)).to be(true)
    expect(same_object?(Car.new, Car.new)).to be(false)
  end

  it "formats car brand" do
    expect(format_car("Ford")).to eq("Car(Ford)")
  end
end
