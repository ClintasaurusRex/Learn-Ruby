# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

RSpec.describe "Lesson 03: Instance vs class methods" do
  it "identifies class method type" do
    expect(method_type_for_counter_total).to eq("class method")
  end

  it "identifies instance method type" do
    expect(method_type_for_label).to eq("instance method")
  end

  it "formats counter label" do
    expect(format_counter_label("A")).to eq("Counter<A>")
  end

  it "increments total" do
    expect(increment_total(2)).to eq(3)
  end

  it "checks class receiver" do
    expect(class_receiver?("Class")).to be(true)
    expect(class_receiver?("Counter")).to be(false)
  end
end
