# frozen_string_literal: true

# ============================================================
# Lesson 05 — Methods, Procs, and Lambdas
# test_lesson.rb — RSpec tests (fail on unmodified exercises)
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 05: Methods, Procs, and Lambdas" do
  # ----------------------------------------------------------
  # Exercise 1: format_name
  # ----------------------------------------------------------
  describe "#format_name" do
    it "returns 'First Last' by default (style: :full)" do
      expect(format_name("John", "Doe")).to eq("John Doe")
    end

    it "returns 'Last, First' with style: :last" do
      expect(format_name("Jane", "Smith", style: :last)).to eq("Smith, Jane")
    end

    it "returns initials with style: :initials" do
      expect(format_name("Alice", "Brown", style: :initials)).to eq("A.B.")
    end

    it "works with different names" do
      expect(format_name("Bob", "Marley")).to eq("Bob Marley")
      expect(format_name("Bob", "Marley", style: :last)).to eq("Marley, Bob")
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: stats
  # ----------------------------------------------------------
  describe "#stats" do
    let(:result) { stats(10, 20, 30, 40) }

    it "returns a Hash" do
      expect(result).to be_a(Hash)
    end

    it "returns the correct count" do
      expect(result[:count]).to eq(4)
    end

    it "returns the correct sum" do
      expect(result[:sum]).to eq(100)
    end

    it "returns the correct min" do
      expect(result[:min]).to eq(10)
    end

    it "returns the correct max" do
      expect(result[:max]).to eq(40)
    end

    it "returns the correct average" do
      expect(result[:average]).to eq(25.0)
    end

    it "works with a single number" do
      single = stats(42)
      expect(single[:count]).to eq(1)
      expect(single[:sum]).to eq(42)
      expect(single[:average]).to eq(42.0)
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: long_word Proc
  # ----------------------------------------------------------
  describe "long_word Proc" do
    it "is defined as a Proc" do
      expect(long_word).to be_a(Proc)
    end

    it "returns true for words longer than 5 characters" do
      expect(long_word.call("elephant")).to be true
      expect(long_word.call("cherry")).to be true
    end

    it "returns false for words with 5 or fewer characters" do
      expect(long_word.call("hello")).to be false
      expect(long_word.call("hi")).to be false
      expect(long_word.call("cat")).to be false
    end

    it "can be used with Array#select" do
      words = ["hi", "hello", "elephant", "ox", "cherry"]
      expect(words.select(&long_word)).to eq(["elephant", "cherry"])
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: safe_sqrt Lambda
  # ----------------------------------------------------------
  describe "safe_sqrt Lambda" do
    it "is defined as a lambda" do
      expect(safe_sqrt).to be_a(Proc)
      expect(safe_sqrt.lambda?).to be true
    end

    it "returns the square root of a positive number" do
      expect(safe_sqrt.call(9)).to eq(3.0)
      expect(safe_sqrt.call(4)).to eq(2.0)
    end

    it "returns the square root of zero" do
      expect(safe_sqrt.call(0)).to eq(0.0)
    end

    it "returns nil for a negative number" do
      expect(safe_sqrt.call(-1)).to be_nil
      expect(safe_sqrt.call(-100)).to be_nil
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: collect_results
  # ----------------------------------------------------------
  describe "#collect_results" do
    it "collects yielded results into an array" do
      result = collect_results(5) { |i| i * i }
      expect(result).to eq([1, 4, 9, 16, 25])
    end

    it "works with any block" do
      result = collect_results(3) { |i| i * 10 }
      expect(result).to eq([10, 20, 30])
    end

    it "returns an Array" do
      expect(collect_results(2) { |i| i }).to be_a(Array)
    end

    it "returns an array of the correct length" do
      result = collect_results(4) { |i| i }
      expect(result.length).to eq(4)
    end
  end

  # ----------------------------------------------------------
  # Exercise 6: word_length and lengths
  # ----------------------------------------------------------
  describe "#word_length" do
    it "returns the length of a string" do
      expect(word_length("cat")).to eq(3)
      expect(word_length("elephant")).to eq(8)
      expect(word_length("ox")).to eq(2)
    end
  end

  describe "lengths variable" do
    it "is an Array" do
      expect(lengths).to be_a(Array)
    end

    it "contains the correct word lengths" do
      expect(lengths).to eq([3, 8, 2])
    end
  end

  # ----------------------------------------------------------
  # Exercise 7: make_adder closure
  # ----------------------------------------------------------
  describe "#make_adder" do
    it "returns a lambda" do
      adder = make_adder(5)
      expect(adder).to be_a(Proc)
      expect(adder.lambda?).to be true
    end

    it "creates an adder that adds the given base" do
      add_five = make_adder(5)
      expect(add_five.call(3)).to eq(8)
      expect(add_five.call(10)).to eq(15)
    end

    it "creates independent adders" do
      add_five = make_adder(5)
      add_ten  = make_adder(10)
      expect(add_five.call(0)).to eq(5)
      expect(add_ten.call(0)).to eq(10)
    end

    it "closures are independent — changing one does not affect others" do
      add_one   = make_adder(1)
      add_hundred = make_adder(100)
      expect(add_one.call(99)).to eq(100)
      expect(add_hundred.call(0)).to eq(100)
    end
  end
end
