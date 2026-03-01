# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 04: Controllers" do
  it "action_result returns redirect or render" do
    expect(action_result(true)).to eq(:redirect)
    expect(action_result(false)).to eq(:render)
  end

  it "callback_chain has expected order" do
    expect(callback_chain).to eq(%i[before_action action render_response])
  end
end
