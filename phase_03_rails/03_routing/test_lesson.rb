# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 03: Routing" do
  it "restful_actions returns 7 actions" do
    expect(restful_actions).to eq(%i[index show new create edit update destroy])
  end

  it "route_matches? compares verb and path" do
    expect(route_matches?(verb: "GET", path: "/posts", expected_verb: "GET", expected_path: "/posts")).to eq(true)
    expect(route_matches?(verb: "POST", path: "/posts", expected_verb: "GET", expected_path: "/posts")).to eq(false)
  end
end
