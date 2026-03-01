# frozen_string_literal: true

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 06: Models and Active Record" do
  it "crud_labels returns full CRUD mapping" do
    expect(crud_labels).to eq(create: "INSERT", read: "SELECT", update: "UPDATE", delete: "DELETE")
  end

  it "valid_model_setup? requires validation and scope" do
    expect(valid_model_setup?(has_validation: true, has_scope: true)).to eq(true)
    expect(valid_model_setup?(has_validation: true, has_scope: false)).to eq(false)
  end
end
