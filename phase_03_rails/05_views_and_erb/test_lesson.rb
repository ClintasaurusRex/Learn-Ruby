# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 05: Views and ERB" do
  it "erb_echo converts values to string" do
    expect(erb_echo(123)).to eq("123")
  end

  it "render_state identifies empty vs list" do
    expect(render_state([])).to eq("empty")
    expect(render_state([1])).to eq("list")
  end
end
