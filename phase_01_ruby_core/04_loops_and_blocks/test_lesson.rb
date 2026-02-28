# frozen_string_literal: true

# ============================================================
# Lesson 04 — Loops and Blocks
# test_lesson.rb — RSpec tests (fail on unmodified exercises)
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 04: Loops and Blocks" do
  # ----------------------------------------------------------
  # Exercise 1: countdown
  # ----------------------------------------------------------
  describe "#countdown" do
    it "returns an Array" do
      expect(countdown(3)).to be_a(Array)
    end

    it "counts from n down to 1 for n=5" do
      expect(countdown(5)).to eq([5, 4, 3, 2, 1])
    end

    it "counts from n down to 1 for n=3" do
      expect(countdown(3)).to eq([3, 2, 1])
    end

    it "returns [1] when n=1" do
      expect(countdown(1)).to eq([1])
    end

    it "returns the correct number of elements" do
      expect(countdown(7).length).to eq(7)
    end

    it "starts with n and ends with 1" do
      result = countdown(10)
      expect(result.first).to eq(10)
      expect(result.last).to eq(1)
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: factorial
  # ----------------------------------------------------------
  describe "#factorial" do
    it "returns 1 for factorial(0)" do
      expect(factorial(0)).to eq(1)
    end

    it "returns 1 for factorial(1)" do
      expect(factorial(1)).to eq(1)
    end

    it "returns 120 for factorial(5)" do
      expect(factorial(5)).to eq(120)
    end

    it "returns 720 for factorial(6)" do
      expect(factorial(6)).to eq(720)
    end

    it "returns 24 for factorial(4)" do
      expect(factorial(4)).to eq(24)
    end

    it "returns an Integer" do
      expect(factorial(5)).to be_a(Integer)
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: sum_with_each
  # ----------------------------------------------------------
  describe "#sum_with_each" do
    it "returns 0 for an empty array" do
      expect(sum_with_each([])).to eq(0)
    end

    it "sums [1, 2, 3, 4] to 10" do
      expect(sum_with_each([1, 2, 3, 4])).to eq(10)
    end

    it "sums [10, 20, 30] to 60" do
      expect(sum_with_each([10, 20, 30])).to eq(60)
    end

    it "works with a single element" do
      expect(sum_with_each([42])).to eq(42)
    end

    it "works with negative numbers" do
      expect(sum_with_each([-1, -2, -3])).to eq(-6)
    end

    it "returns a Numeric result" do
      expect(sum_with_each([1, 2, 3])).to be_a(Numeric)
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: group_by_length
  # ----------------------------------------------------------
  describe "#group_by_length" do
    it "returns a Hash" do
      expect(group_by_length(["cat", "ox"])).to be_a(Hash)
    end

    it "groups words by their length" do
      result = group_by_length(["cat", "ox", "bee", "ant"])
      expect(result[3]).to contain_exactly("cat", "bee", "ant")
      expect(result[2]).to eq(["ox"])
    end

    it "returns an empty Hash for an empty array" do
      expect(group_by_length([])).to eq({})
    end

    it "handles all words of the same length" do
      result = group_by_length(["hi", "me", "no"])
      expect(result[2]).to contain_exactly("hi", "me", "no")
    end

    it "uses Integer keys (word lengths)" do
      result = group_by_length(["hello"])
      expect(result.keys.first).to be_a(Integer)
    end

    it "groups longer words correctly" do
      result = group_by_length(["hello", "world", "hi"])
      expect(result[5]).to contain_exactly("hello", "world")
      expect(result[2]).to eq(["hi"])
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: run_and_collect
  # ----------------------------------------------------------
  describe "#run_and_collect" do
    it "returns an Array" do
      expect(run_and_collect(3) { |i| i }).to be_a(Array)
    end

    it "yields numbers 1 through n" do
      result = run_and_collect(3) { |i| i }
      expect(result).to eq([1, 2, 3])
    end

    it "collects block return values" do
      result = run_and_collect(3) { |i| i * 2 }
      expect(result).to eq([2, 4, 6])
    end

    it "works with squares" do
      result = run_and_collect(4) { |i| i**2 }
      expect(result).to eq([1, 4, 9, 16])
    end

    it "returns an array of the correct length" do
      result = run_and_collect(5) { |i| i }
      expect(result.length).to eq(5)
    end

    it "works with n=1" do
      result = run_and_collect(1) { |i| i * 10 }
      expect(result).to eq([10])
    end
  end
end
