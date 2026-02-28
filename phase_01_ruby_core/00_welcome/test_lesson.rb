# frozen_string_literal: true

# ============================================================
# Lesson 00 — Welcome to Ruby
# test_lesson.rb — RSpec tests (fail on unmodified exercises)
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 00: Welcome to Ruby" do
  # ----------------------------------------------------------
  # Exercise 1: output_demo
  # ----------------------------------------------------------
  describe "#output_demo" do
    it "returns a String" do
      expect(output_demo).to be_a(String)
    end

    it "mentions puts, p, and print in the description" do
      result = output_demo
      expect(result).to include("puts")
      expect(result).to include("print")
      expect(result).to include("p ")
    end

    it "returns the exact expected description string" do
      expect(output_demo).to eq(
        "puts prints a newline, p shows inspect, print has no newline"
      )
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: interpolate_name
  # ----------------------------------------------------------
  describe "#interpolate_name" do
    it "returns a String" do
      expect(interpolate_name("Alice", 30)).to be_a(String)
    end

    it "interpolates the name into the result" do
      expect(interpolate_name("Alice", 30)).to include("Alice")
      expect(interpolate_name("Bob", 25)).to include("Bob")
    end

    it "interpolates the age into the result" do
      expect(interpolate_name("Alice", 30)).to include("30")
      expect(interpolate_name("Bob", 25)).to include("25")
    end

    it "returns the exact formatted sentence for Alice, 30" do
      expect(interpolate_name("Alice", 30)).to eq(
        "My name is Alice and I am 30 years old."
      )
    end

    it "returns the exact formatted sentence for any name and age" do
      expect(interpolate_name("Charlie", 17)).to eq(
        "My name is Charlie and I am 17 years old."
      )
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: add_comment
  # ----------------------------------------------------------
  describe "#add_comment" do
    it "returns a String" do
      expect(add_comment("hello")).to be_a(String)
    end

    it "returns the input string unchanged" do
      expect(add_comment("hello")).to eq("hello")
      expect(add_comment("test string")).to eq("test string")
    end

    it "returns any arbitrary string unchanged" do
      expect(add_comment("Ruby is fun!")).to eq("Ruby is fun!")
    end

    it "returns an empty string unchanged" do
      expect(add_comment("")).to eq("")
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: multi_line_output
  # ----------------------------------------------------------
  describe "#multi_line_output" do
    it "returns an Array" do
      expect(multi_line_output).to be_a(Array)
    end

    it "returns exactly 3 elements" do
      expect(multi_line_output.length).to eq(3)
    end

    it "returns exactly ['Line 1', 'Line 2', 'Line 3']" do
      expect(multi_line_output).to eq(["Line 1", "Line 2", "Line 3"])
    end

    it "contains only String elements" do
      multi_line_output.each do |item|
        expect(item).to be_a(String)
      end
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: inspect_value
  # ----------------------------------------------------------
  describe "#inspect_value" do
    it "returns a String" do
      expect(inspect_value(42)).to be_a(String)
    end

    it "returns the inspect of a String (with surrounding quotes)" do
      expect(inspect_value("hello")).to eq('"hello"')
    end

    it "returns the inspect of an Integer" do
      expect(inspect_value(42)).to eq("42")
    end

    it "returns the inspect of an Array" do
      expect(inspect_value([1, 2, 3])).to eq("[1, 2, 3]")
    end

    it "returns 'nil' for nil input" do
      expect(inspect_value(nil)).to eq("nil")
    end

    it "returns 'true' for true input" do
      expect(inspect_value(true)).to eq("true")
    end

    it "matches val.inspect for any value" do
      [42, "test", [1, 2], nil, false, { a: 1 }].each do |val|
        expect(inspect_value(val)).to eq(val.inspect)
      end
    end
  end
end
