# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

RSpec.describe "Lesson 00: OOP Overview" do
  it "returns the OOP reason sentence" do
    expect(oop_reason).to eq("OOP keeps related state and behavior together.")
  end

  it "returns the class/object pair string" do
    expect(class_object_pair).to eq("Class: User | Object: ava")
  end

  it "identifies active status" do
    expect(active_status?("active")).to be(true)
    expect(active_status?("archived")).to be(false)
  end

  it "returns state and behavior labels" do
    expect(state_and_behavior_labels).to eq(["state:name", "behavior:active?"])
  end

  it "formats user name in uppercase" do
    expect(format_user_name("ava")).to eq("User<AVA>")
  end
end
