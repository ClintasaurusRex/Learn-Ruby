# frozen_string_literal: true

# ============================================================
# Lesson 06 — Modules and Mixins
# test_lesson.rb — RSpec tests
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 06: Modules and Mixins" do
  # ----------------------------------------------------------
  # Exercise 1: Serializable
  # ----------------------------------------------------------
  describe "Serializable module" do
    let(:product) { Product.new("Widget", 9.99, "tools") }

    it "is included in Product" do
      expect(Product.ancestors).to include(Serializable)
    end

    describe "#to_csv" do
      it "returns a comma-separated string of values" do
        expect(product.to_csv).to eq("Widget,9.99,tools")
      end

      it "returns a String" do
        expect(product.to_csv).to be_a(String)
      end
    end

    describe "#to_h" do
      it "returns a Hash" do
        expect(product.to_h).to be_a(Hash)
      end

      it "maps variable names (without @) to values" do
        h = product.to_h
        expect(h[:name]).to eq("Widget")
        expect(h[:price]).to eq(9.99)
        expect(h[:category]).to eq("tools")
      end

      it "does not include @ in keys" do
        keys = product.to_h.keys
        expect(keys).to all(be_a(Symbol))
        expect(keys.map(&:to_s)).to all(satisfy { |k| !k.start_with?("@") })
      end
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: Countable
  # ----------------------------------------------------------
  describe "Countable module" do
    before { Widget.instance_variable_set(:@count, 0) }

    it "is included in Widget" do
      expect(Widget.ancestors).to include(Countable)
    end

    it "starts with a count of 0" do
      expect(Widget.instance_count).to eq(0)
    end

    it "increments count on each new instance" do
      Widget.new("Bolt")
      expect(Widget.instance_count).to eq(1)
      Widget.new("Nut")
      expect(Widget.instance_count).to eq(2)
    end

    it "count reflects all created instances" do
      3.times { |i| Widget.new("Item #{i}") }
      expect(Widget.instance_count).to eq(3)
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: Comparable Temperature
  # ----------------------------------------------------------
  describe "Temperature with Comparable" do
    let(:cold)  { Temperature.new(0)   }
    let(:body)  { Temperature.new(37)  }
    let(:boil)  { Temperature.new(100) }

    it "includes Comparable" do
      expect(Temperature.ancestors).to include(Comparable)
    end

    it "compares temperatures with <" do
      expect(cold < body).to be true
      expect(boil < body).to be false
    end

    it "compares temperatures with >" do
      expect(boil > body).to be true
      expect(cold > body).to be false
    end

    it "compares temperatures with ==" do
      expect(Temperature.new(37) == Temperature.new(37)).to be true
      expect(cold == boil).to be false
    end

    it "finds min from an array" do
      expect([boil, body, cold].min.degrees).to eq(0)
    end

    it "finds max from an array" do
      expect([boil, body, cold].max.degrees).to eq(100)
    end

    it "sorts an array of temperatures" do
      sorted = [boil, cold, body].sort.map(&:degrees)
      expect(sorted).to eq([0, 37, 100])
    end

    it "supports between?" do
      expect(body.between?(cold, boil)).to be true
      expect(cold.between?(body, boil)).to be false
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: Enumerable WordCollection
  # ----------------------------------------------------------
  describe "WordCollection with Enumerable" do
    let(:wc) { WordCollection.new("apple", "banana", "cherry", "date") }

    it "includes Enumerable" do
      expect(WordCollection.ancestors).to include(Enumerable)
    end

    it "supports sort" do
      expect(wc.sort).to eq(["apple", "banana", "cherry", "date"])
    end

    it "supports select" do
      expect(wc.select { |w| w.length > 5 }).to eq(["banana", "cherry"])
    end

    it "supports map" do
      expect(wc.map(&:upcase)).to eq(["APPLE", "BANANA", "CHERRY", "DATE"])
    end

    it "supports min and max" do
      expect(wc.min).to eq("apple")
      expect(wc.max).to eq("date")
    end

    it "supports count" do
      expect(wc.count).to eq(4)
    end

    it "supports any?" do
      expect(wc.any? { |w| w.start_with?("b") }).to be true
      expect(wc.any? { |w| w.start_with?("z") }).to be false
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: Shapes namespace
  # ----------------------------------------------------------
  describe "Shapes module" do
    describe "Shapes::Circle" do
      it "calculates the area of a circle with radius 5" do
        expect(Shapes::Circle.new(5).area).to eq(78.54)
      end

      it "calculates the area of a circle with radius 1" do
        expect(Shapes::Circle.new(1).area).to eq(3.14)
      end

      it "returns a Float" do
        expect(Shapes::Circle.new(3).area).to be_a(Float)
      end
    end

    describe "Shapes::Rectangle" do
      it "calculates the area of a rectangle" do
        expect(Shapes::Rectangle.new(4, 6).area).to eq(24.0)
        expect(Shapes::Rectangle.new(3, 3).area).to eq(9.0)
      end

      it "returns a Float" do
        expect(Shapes::Rectangle.new(2, 5).area).to be_a(Float)
      end
    end
  end
end
