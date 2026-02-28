# frozen_string_literal: true

# ============================================================
# Lesson 01 — Ruby Basics
# test_lesson.rb — RSpec tests (fail on unmodified exercises)
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 01: Ruby Basics" do
  # ----------------------------------------------------------
  # Exercise 1: data_type_of
  # ----------------------------------------------------------
  describe "#data_type_of" do
    it "returns 'String' for a string value" do
      expect(data_type_of("hello")).to eq("String")
    end

    it "returns 'Integer' for an integer value" do
      expect(data_type_of(42)).to eq("Integer")
    end

    it "returns 'Float' for a float value" do
      expect(data_type_of(3.14)).to eq("Float")
    end

    it "returns 'TrueClass' for true" do
      expect(data_type_of(true)).to eq("TrueClass")
    end

    it "returns 'FalseClass' for false" do
      expect(data_type_of(false)).to eq("FalseClass")
    end

    it "returns 'NilClass' for nil" do
      expect(data_type_of(nil)).to eq("NilClass")
    end

    it "returns 'Symbol' for a symbol" do
      expect(data_type_of(:my_symbol)).to eq("Symbol")
    end

    it "returns a String, not a Class object" do
      expect(data_type_of(1)).to be_a(String)
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: arithmetic
  # ----------------------------------------------------------
  describe "#arithmetic" do
    let(:result) { arithmetic(10, 3) }

    it "returns a Hash" do
      expect(result).to be_a(Hash)
    end

    it "calculates the correct sum" do
      expect(result[:sum]).to eq(13)
    end

    it "calculates the correct difference" do
      expect(result[:difference]).to eq(7)
    end

    it "calculates the correct product" do
      expect(result[:product]).to eq(30)
    end

    it "calculates the quotient as a Float (not integer division)" do
      expect(result[:quotient]).to be_a(Float)
      expect(result[:quotient]).to be_within(0.0001).of(3.3333)
    end

    it "calculates the correct modulo" do
      expect(result[:modulo]).to eq(1)
    end

    it "calculates the correct power" do
      expect(result[:power]).to eq(1000)
    end

    it "works with different inputs" do
      r = arithmetic(4, 2)
      expect(r[:sum]).to eq(6)
      expect(r[:difference]).to eq(2)
      expect(r[:product]).to eq(8)
      expect(r[:quotient]).to eq(2.0)
      expect(r[:modulo]).to eq(0)
      expect(r[:power]).to eq(16)
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: compare
  # ----------------------------------------------------------
  describe "#compare" do
    it "returns a Hash" do
      expect(compare(1, 2)).to be_a(Hash)
    end

    it "detects when values are equal" do
      expect(compare(5, 5)[:equal]).to be true
      expect(compare(5, 6)[:equal]).to be false
    end

    it "detects when the first value is greater" do
      expect(compare(10, 5)[:greater]).to be true
      expect(compare(5, 10)[:greater]).to be false
    end

    it "detects when the first value is less" do
      expect(compare(3, 7)[:less]).to be true
      expect(compare(7, 3)[:less]).to be false
    end

    it "returns all false for greater and less when values are equal" do
      r = compare(5, 5)
      expect(r[:equal]).to be true
      expect(r[:greater]).to be false
      expect(r[:less]).to be false
    end

    it "works with negative numbers" do
      r = compare(-5, -10)
      expect(r[:equal]).to be false
      expect(r[:greater]).to be true
      expect(r[:less]).to be false
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: convert_to_int
  # ----------------------------------------------------------
  describe "#convert_to_int" do
    it "converts a numeric string to an Integer" do
      expect(convert_to_int("42")).to eq(42)
    end

    it "converts a Float to an Integer by truncating (not rounding)" do
      expect(convert_to_int(3.9)).to eq(3)
    end

    it "converts nil to 0" do
      expect(convert_to_int(nil)).to eq(0)
    end

    it "converts a string with trailing non-digits (stops at first non-digit)" do
      expect(convert_to_int("7px")).to eq(7)
    end

    it "converts a non-numeric string to 0" do
      expect(convert_to_int("abc")).to eq(0)
    end

    it "returns an Integer type" do
      expect(convert_to_int("10")).to be_a(Integer)
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: convert_to_string
  # ----------------------------------------------------------
  describe "#convert_to_string" do
    it "converts an Integer to a String" do
      expect(convert_to_string(42)).to eq("42")
    end

    it "converts a Float to a String" do
      expect(convert_to_string(3.14)).to eq("3.14")
    end

    it "converts true to the string 'true'" do
      expect(convert_to_string(true)).to eq("true")
    end

    it "converts nil to an empty string" do
      expect(convert_to_string(nil)).to eq("")
    end

    it "converts a Symbol to a String without the colon" do
      expect(convert_to_string(:hello)).to eq("hello")
    end

    it "returns a String type" do
      expect(convert_to_string(99)).to be_a(String)
    end
  end
end
