# frozen_string_literal: true

# ============================================================
# Lesson 03 — Arrays and Hashes
# test_lesson.rb — RSpec tests (fail on unmodified exercises)
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 03: Arrays and Hashes" do
  # ----------------------------------------------------------
  # Exercise 1: double_all
  # ----------------------------------------------------------
  describe "#double_all" do
    it "doubles each element in a positive array" do
      expect(double_all([1, 2, 3])).to eq([2, 4, 6])
    end

    it "doubles a single-element array" do
      expect(double_all([7])).to eq([14])
    end

    it "handles zero correctly" do
      expect(double_all([0, 0, 0])).to eq([0, 0, 0])
    end

    it "handles negative numbers" do
      expect(double_all([0, -5, 10])).to eq([0, -10, 20])
    end

    it "returns an empty array for an empty input" do
      expect(double_all([])).to eq([])
    end

    it "returns a new array and does not mutate the original" do
      original = [1, 2, 3]
      result = double_all(original)
      expect(result).not_to equal(original)
      expect(original).to eq([1, 2, 3])
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: select_evens
  # ----------------------------------------------------------
  describe "#select_evens" do
    it "returns only even numbers from a mixed array" do
      expect(select_evens([1, 2, 3, 4, 5, 6])).to eq([2, 4, 6])
    end

    it "returns an empty array when there are no evens" do
      expect(select_evens([1, 3, 5])).to eq([])
    end

    it "returns all elements when all are even" do
      expect(select_evens([2, 4, 6])).to eq([2, 4, 6])
    end

    it "handles zero (zero is even)" do
      expect(select_evens([0, 1, 2])).to eq([0, 2])
    end

    it "handles negative even numbers" do
      expect(select_evens([-4, -3, -2, -1])).to eq([-4, -2])
    end

    it "returns an empty array for empty input" do
      expect(select_evens([])).to eq([])
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: first_long_word
  # ----------------------------------------------------------
  describe "#first_long_word" do
    it "returns the first word longer than 5 characters" do
      expect(first_long_word(["hi", "hello", "elephant"])).to eq("elephant")
    end

    it "returns nil when no word is longer than 5 characters" do
      expect(first_long_word(["cat", "dog", "fox"])).to be_nil
    end

    it "returns the first match, not all matches" do
      expect(first_long_word(["cherry", "banana", "kiwi"])).to eq("cherry")
    end

    it "returns nil for an empty array" do
      expect(first_long_word([])).to be_nil
    end

    it "does not match words of exactly 5 characters (boundary check)" do
      expect(first_long_word(["hello", "world"])).to be_nil
    end

    it "matches a word of 6 characters" do
      expect(first_long_word(["foobar"])).to eq("foobar")
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: array_stats
  # ----------------------------------------------------------
  describe "#array_stats" do
    let(:result) { array_stats([1, 2, 3, 4, 5]) }

    it "returns a Hash" do
      expect(result).to be_a(Hash)
    end

    it "returns the correct :min" do
      expect(result[:min]).to eq(1)
    end

    it "returns the correct :max" do
      expect(result[:max]).to eq(5)
    end

    it "returns the correct :sum" do
      expect(result[:sum]).to eq(15)
    end

    it "returns the correct :count" do
      expect(result[:count]).to eq(5)
    end

    it "returns the correct :average as a Float" do
      expect(result[:average]).to eq(3.0)
      expect(result[:average]).to be_a(Float)
    end

    it "works with a single-element array" do
      s = array_stats([42])
      expect(s[:min]).to eq(42)
      expect(s[:max]).to eq(42)
      expect(s[:sum]).to eq(42)
      expect(s[:count]).to eq(1)
      expect(s[:average]).to eq(42.0)
    end

    it "computes a non-integer average correctly" do
      expect(array_stats([1, 2])[:average]).to eq(1.5)
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: count_occurrences
  # ----------------------------------------------------------
  describe "#count_occurrences" do
    it "counts each unique element" do
      result = count_occurrences(["a", "b", "a", "c", "b", "a"])
      expect(result["a"]).to eq(3)
      expect(result["b"]).to eq(2)
      expect(result["c"]).to eq(1)
    end

    it "returns a Hash" do
      expect(count_occurrences(["x"])).to be_a(Hash)
    end

    it "returns an empty hash for an empty array" do
      expect(count_occurrences([])).to eq({})
    end

    it "counts a single element appearing once" do
      expect(count_occurrences(["only"])).to eq({ "only" => 1 })
    end

    it "handles all identical elements" do
      expect(count_occurrences(["z", "z", "z"])).to eq({ "z" => 3 })
    end

    it "works with symbols as elements" do
      result = count_occurrences([:ruby, :python, :ruby])
      expect(result[:ruby]).to eq(2)
      expect(result[:python]).to eq(1)
    end
  end

  # ----------------------------------------------------------
  # Exercise 6: extract_field
  # ----------------------------------------------------------
  describe "#extract_field" do
    let(:users) do
      [
        { name: "Alice", age: 30 },
        { name: "Bob",   age: 25 },
        { name: "Carol", age: 35 }
      ]
    end

    it "extracts a string field from each hash" do
      expect(extract_field(users, :name)).to eq(["Alice", "Bob", "Carol"])
    end

    it "extracts an integer field from each hash" do
      expect(extract_field(users, :age)).to eq([30, 25, 35])
    end

    it "returns an Array" do
      expect(extract_field(users, :name)).to be_a(Array)
    end

    it "returns an empty array for an empty input" do
      expect(extract_field([], :name)).to eq([])
    end

    it "returns an array of nils if the key is missing from all hashes" do
      expect(extract_field(users, :email)).to eq([nil, nil, nil])
    end

    it "works with numeric values" do
      products = [{ id: 1, price: 9.99 }, { id: 2, price: 24.99 }]
      expect(extract_field(products, :price)).to eq([9.99, 24.99])
    end
  end
end
