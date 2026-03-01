# frozen_string_literal: true

require "rspec"
require_relative ENV.fetch("LESSON_FILE", "exercises")

RSpec.describe "Lesson 02: initialize and attributes" do
  it "returns initialize phrase" do
    expect(initialize_phrase).to eq("initialize sets state")
  end

  it "formats title" do
    expect(format_title("Ruby")).to eq("Book(Ruby)")
  end

  it "checks positive pages" do
    expect(positive_pages?(1)).to be(true)
    expect(positive_pages?(0)).to be(false)
  end

  it "returns state pair" do
    expect(state_pair("Ruby", 300)).to eq(["Ruby", 300])
  end

  it "formats pages label" do
    expect(pages_label("Ruby", 300)).to eq("Ruby has 300 pages")
  end
end
