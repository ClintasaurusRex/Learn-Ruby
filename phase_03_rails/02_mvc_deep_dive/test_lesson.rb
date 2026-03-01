# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 02: MVC Deep Dive" do
  it "classify_layer returns model for validation code" do
    expect(classify_layer("validates :name, presence: true")).to eq(:model)
  end

  it "classify_layer returns controller for flow code" do
    expect(classify_layer("redirect_to root_path")).to eq(:controller)
  end

  it "good_boundary? returns true when all layers are clean" do
    expect(good_boundary?(model_logic: true, controller_flow: true, view_markup: true)).to eq(true)
  end
end
