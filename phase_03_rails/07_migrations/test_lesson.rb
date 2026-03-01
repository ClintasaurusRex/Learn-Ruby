# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 07: Migrations" do
  it "migration_methods returns change/up/down" do
    expect(migration_methods).to eq(%i[change up down])
  end

  it "reversible_choice? respects reversibility" do
    expect(reversible_choice?(uses_change: true, reversible_operation: true)).to eq(true)
    expect(reversible_choice?(uses_change: true, reversible_operation: false)).to eq(false)
  end
end
