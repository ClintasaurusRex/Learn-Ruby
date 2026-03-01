# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 01: New App and Structure" do
  it "important_paths returns a hash" do
    expect(important_paths).to be_a(Hash)
  end

  it "important_paths includes required keys" do
    expect(important_paths&.keys).to include(:routes, :controllers, :views, :migrations)
  end

  it "valid_structure? validates required keys" do
    expect(valid_structure?(routes: "x", controllers: "y", views: "z", migrations: "m")).to eq(true)
    expect(valid_structure?(routes: "x", controllers: "y")).to eq(false)
  end
end
