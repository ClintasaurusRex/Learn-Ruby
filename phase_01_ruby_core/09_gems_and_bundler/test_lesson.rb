# frozen_string_literal: true

# ============================================================
# Lesson 09 — Gems and Bundler
# test_lesson.rb — RSpec tests
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require "json"
require "csv"
require_relative "exercises"

RSpec.describe "Lesson 09: Gems and Bundler" do
  # ----------------------------------------------------------
  # Exercise 1: json_round_trip
  # ----------------------------------------------------------
  describe "#json_round_trip" do
    it "returns a Hash" do
      expect(json_round_trip({ name: "Alice" })).to be_a(Hash)
    end

    it "round-trips a simple hash (symbol keys become string keys)" do
      result = json_round_trip({ name: "Alice", age: 30 })
      expect(result["name"]).to eq("Alice")
      expect(result["age"]).to eq(30)
    end

    it "round-trips an array" do
      result = json_round_trip([1, 2, 3])
      expect(result).to eq([1, 2, 3])
    end

    it "round-trips boolean values" do
      result = json_round_trip({ active: true, deleted: false })
      expect(result["active"]).to be true
      expect(result["deleted"]).to be false
    end

    it "round-trips nested structures" do
      data = { user: { name: "Bob", scores: [95, 87] } }
      result = json_round_trip(data)
      expect(result["user"]["name"]).to eq("Bob")
      expect(result["user"]["scores"]).to eq([95, 87])
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: parse_json_config
  # ----------------------------------------------------------
  describe "#parse_json_config" do
    let(:json) { '{"host":"localhost","port":5432,"debug":false}' }
    let(:result) { parse_json_config(json) }

    it "returns a Hash" do
      expect(result).to be_a(Hash)
    end

    it "uses symbol keys" do
      expect(result.keys).to all(be_a(Symbol))
    end

    it "parses the correct values" do
      expect(result[:host]).to eq("localhost")
      expect(result[:port]).to eq(5432)
      expect(result[:debug]).to be false
    end

    it "works with nested objects" do
      nested_json = '{"database":{"host":"db.example.com","port":5432}}'
      result = parse_json_config(nested_json)
      expect(result[:database][:host]).to eq("db.example.com")
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: build_gemfile_info
  # ----------------------------------------------------------
  describe "#build_gemfile_info" do
    let(:gems) do
      [
        { name: "rspec",    version: "~> 3.12" },
        { name: "pry",      version: "~> 0.14" },
        { name: "colorize", version: "~> 1.1" }
      ]
    end

    it "returns a String" do
      expect(build_gemfile_info(gems)).to be_a(String)
    end

    it "includes each gem name" do
      result = build_gemfile_info(gems)
      expect(result).to include("rspec")
      expect(result).to include("pry")
      expect(result).to include("colorize")
    end

    it "includes each version constraint" do
      result = build_gemfile_info(gems)
      expect(result).to include("~> 3.12")
      expect(result).to include("~> 0.14")
      expect(result).to include("~> 1.1")
    end

    it "uses the correct gem line format" do
      result = build_gemfile_info([{ name: "rspec", version: "~> 3.12" }])
      expect(result).to eq('gem "rspec", "~> 3.12"')
    end

    it "puts each gem on its own line" do
      result = build_gemfile_info(gems)
      lines = result.split("\n").reject(&:empty?)
      expect(lines.count).to eq(3)
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: version_constraint_type
  # ----------------------------------------------------------
  describe "#version_constraint_type" do
    it "identifies pessimistic minor: ~> X.Y" do
      expect(version_constraint_type("~> 3.12")).to eq(:pessimistic_minor)
      expect(version_constraint_type("~> 1.1")).to eq(:pessimistic_minor)
    end

    it "identifies pessimistic patch: ~> X.Y.Z" do
      expect(version_constraint_type("~> 3.12.0")).to eq(:pessimistic_patch)
      expect(version_constraint_type("~> 1.1.0")).to eq(:pessimistic_patch)
    end

    it "identifies minimum: >= X" do
      expect(version_constraint_type(">= 2.0")).to eq(:minimum)
      expect(version_constraint_type(">= 1")).to eq(:minimum)
    end

    it "identifies exact: = X" do
      expect(version_constraint_type("= 3.12.0")).to eq(:exact)
    end

    it "identifies maximum: < X" do
      expect(version_constraint_type("< 3.0")).to eq(:maximum)
    end

    it "returns :other for unrecognized patterns" do
      expect(version_constraint_type("> 1.0")).to eq(:other)
      expect(version_constraint_type("anything")).to eq(:other)
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: gem_available?
  # ----------------------------------------------------------
  describe "#gem_available?" do
    it "returns true for json (always available)" do
      expect(gem_available?("json")).to be true
    end

    it "returns false for a nonexistent gem" do
      expect(gem_available?("nonexistent_gem_xyz_abc")).to be false
    end

    it "does not raise an error for missing gems" do
      expect { gem_available?("surely_not_installed") }.not_to raise_error
    end

    it "returns a boolean" do
      result = gem_available?("json")
      expect(result).to be(true).or be(false)
    end
  end

  # ----------------------------------------------------------
  # Exercise 6: parse_csv_string
  # ----------------------------------------------------------
  describe "#parse_csv_string" do
    let(:csv) { "name,age,city\nAlice,30,Austin\nBob,25,Denver" }

    context "with headers: true (default)" do
      let(:result) { parse_csv_string(csv) }

      it "returns an Array" do
        expect(result).to be_a(Array)
      end

      it "returns Hashes" do
        expect(result.first).to be_a(Hash)
      end

      it "uses the header row as keys" do
        expect(result.first.keys).to include("name", "age", "city")
      end

      it "returns the correct number of data rows" do
        expect(result.count).to eq(2)
      end

      it "has the correct values" do
        expect(result.first["name"]).to eq("Alice")
        expect(result.last["name"]).to eq("Bob")
      end
    end

    context "with headers: false" do
      let(:result) { parse_csv_string(csv, headers: false) }

      it "returns an Array of Arrays" do
        expect(result.first).to be_a(Array)
      end

      it "includes the header row as the first array" do
        expect(result.first).to eq(["name", "age", "city"])
      end

      it "returns all rows including header" do
        expect(result.count).to eq(3)
      end
    end
  end
end
