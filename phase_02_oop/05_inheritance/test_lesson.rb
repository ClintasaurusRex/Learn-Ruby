# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

RSpec.describe "Lesson 05: Inheritance" do
  it "returns inheritance operator" do
    expect(inheritance_operator).to eq("<")
  end

  it "confirms dog is animal relation" do
    expect(dog_is_animal?).to be(true)
  end

  it "returns base sound" do
    expect(base_sound).to eq("sound")
  end

  it "returns dog sound with inherited base" do
    expect(dog_sound).to eq("sound bark")
  end

  it "returns cat sound with inherited base" do
    expect(cat_sound).to eq("sound meow")
  end
end
