# frozen_string_literal: true

# ============================================================
# Lesson 02 — Strings and Symbols
# test_lesson.rb — RSpec tests
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# Tests FAIL on unmodified exercises.rb (methods return nil).
# Tests PASS when exercises are completed or solutions are used.
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 02: Strings and Symbols" do
  # ----------------------------------------------------------
  # Exercise 1: shout
  # ----------------------------------------------------------
  describe "#shout" do
    it "returns the string upcased with '!' appended" do
      expect(shout("hello")).to eq("HELLO!")
    end

    it "works when the string is already uppercase" do
      expect(shout("RUBY")).to eq("RUBY!")
    end

    it "upcases every character" do
      expect(shout("ruby is great")).to eq("RUBY IS GREAT!")
    end

    it "handles a single character string" do
      expect(shout("a")).to eq("A!")
    end

    it "handles a string with mixed case" do
      expect(shout("Hello World")).to eq("HELLO WORLD!")
    end

    it "returns a String" do
      expect(shout("test")).to be_a(String)
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: titleize
  # ----------------------------------------------------------
  describe "#titleize" do
    it "capitalizes the first letter of each word" do
      expect(titleize("hello world")).to eq("Hello World")
    end

    it "lowercases the remaining letters in each word" do
      expect(titleize("THE QUICK BROWN FOX")).to eq("The Quick Brown Fox")
    end

    it "handles a single word" do
      expect(titleize("ruby")).to eq("Ruby")
    end

    it "handles multiple words" do
      expect(titleize("the quick brown fox")).to eq("The Quick Brown Fox")
    end

    it "returns a String" do
      expect(titleize("hello")).to be_a(String)
    end

    it "handles a mixed-case sentence" do
      expect(titleize("hElLo WoRlD")).to eq("Hello World")
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: palindrome?
  # ----------------------------------------------------------
  describe "#palindrome?" do
    it "returns true for a classic palindrome" do
      expect(palindrome?("racecar")).to be true
    end

    it "returns true ignoring case" do
      expect(palindrome?("Madam")).to be true
    end

    it "returns true ignoring leading/trailing whitespace" do
      expect(palindrome?("  level  ")).to be true
    end

    it "returns false for a non-palindrome" do
      expect(palindrome?("hello")).to be false
    end

    it "returns true for a single character" do
      expect(palindrome?("a")).to be true
    end

    it "returns true for another palindrome" do
      expect(palindrome?("noon")).to be true
    end

    it "returns a boolean" do
      expect(palindrome?("test")).to be(true).or be(false)
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: string_stats
  # ----------------------------------------------------------
  describe "#string_stats" do
    let(:result) { string_stats("hello world") }

    it "returns a Hash" do
      expect(result).to be_a(Hash)
    end

    it "returns the correct :length (total characters including spaces)" do
      expect(result[:length]).to eq(11)
    end

    it "returns the correct :words count" do
      expect(result[:words]).to eq(2)
    end

    it "returns the correct :uppercase value" do
      expect(result[:uppercase]).to eq("HELLO WORLD")
    end

    it "returns the correct :reversed value" do
      expect(result[:reversed]).to eq("dlrow olleh")
    end

    it "works for a single word" do
      stats = string_stats("Ruby")
      expect(stats[:length]).to eq(4)
      expect(stats[:words]).to eq(1)
      expect(stats[:uppercase]).to eq("RUBY")
      expect(stats[:reversed]).to eq("ybuR")
    end

    it "includes all required keys" do
      expect(result.keys).to include(:length, :words, :uppercase, :reversed)
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: symbol_to_strings
  # ----------------------------------------------------------
  describe "#symbol_to_strings" do
    it "converts an array of symbols to strings" do
      expect(symbol_to_strings([:hello, :world])).to eq(["hello", "world"])
    end

    it "returns an Array" do
      expect(symbol_to_strings([:a])).to be_a(Array)
    end

    it "each element is a String" do
      result = symbol_to_strings([:name, :age])
      expect(result).to all(be_a(String))
    end

    it "handles a single-element array" do
      expect(symbol_to_strings([:ruby])).to eq(["ruby"])
    end

    it "handles an empty array" do
      expect(symbol_to_strings([])).to eq([])
    end

    it "converts multiple symbols correctly" do
      expect(symbol_to_strings([:name, :age, :email])).to eq(["name", "age", "email"])
    end
  end

  # ----------------------------------------------------------
  # Exercise 6: apply_transform
  # ----------------------------------------------------------
  describe "#apply_transform" do
    it "applies :upcase to each string" do
      expect(apply_transform(["hello", "world"], :upcase)).to eq(["HELLO", "WORLD"])
    end

    it "applies :downcase to each string" do
      expect(apply_transform(["Hello", "World"], :downcase)).to eq(["hello", "world"])
    end

    it "applies :reverse to each string" do
      expect(apply_transform(["abc", "xyz"], :reverse)).to eq(["cba", "zyx"])
    end

    it "returns an Array" do
      expect(apply_transform(["hi"], :upcase)).to be_a(Array)
    end

    it "handles an empty array" do
      expect(apply_transform([], :upcase)).to eq([])
    end

    it "applies :strip to each string" do
      expect(apply_transform(["  hi  ", "  there  "], :strip)).to eq(["hi", "there"])
    end
  end
end
