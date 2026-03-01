# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 00: Rails Overview" do
  it "request_steps returns an array" do
    expect(request_steps).to be_a(Array)
  end

  it "request_steps has 5 stages" do
    expect(request_steps&.length).to eq(5)
  end

  it "mvc_separated? returns true only when all layer responsibilities are present" do
    expect(mvc_separated?(model_has_sql: true, controller_has_flow: true, view_has_markup: true)).to eq(true)
    expect(mvc_separated?(model_has_sql: false, controller_has_flow: true, view_has_markup: true)).to eq(false)
  end
end
