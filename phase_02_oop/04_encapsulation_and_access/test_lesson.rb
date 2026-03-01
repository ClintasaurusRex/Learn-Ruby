# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

RSpec.describe "Lesson 04: Encapsulation and access control" do
  it "uses private visibility for validator" do
    expect(validator_visibility).to eq("private")
  end

  it "checks positive amount" do
    expect(positive_amount?(10)).to be(true)
    expect(positive_amount?(0)).to be(false)
  end

  it "cannot call private methods directly" do
    expect(can_call_private_directly?).to be(false)
  end

  it "names public entry point" do
    expect(safe_entry_point).to eq("public API")
  end

  it "formats balance label" do
    expect(balance_label(30)).to eq("Balance: 30")
  end
end
