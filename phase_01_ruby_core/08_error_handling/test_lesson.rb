# frozen_string_literal: true

# ============================================================
# Lesson 08 — Error Handling
# test_lesson.rb — RSpec tests
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require_relative "exercises"

RSpec.describe "Lesson 08: Error Handling" do
  # ----------------------------------------------------------
  # Exercise 1: ValidationError
  # ----------------------------------------------------------
  describe "ValidationError" do
    it "inherits from StandardError" do
      expect(ValidationError.ancestors).to include(StandardError)
    end

    it "stores a message accessible via .message" do
      err = ValidationError.new("is required")
      expect(err.message).to eq("is required")
    end

    it "has a field attribute" do
      expect(ValidationError.new("err")).to respond_to(:field)
    end

    it "stores the field when provided" do
      err = ValidationError.new("is blank", field: :email)
      expect(err.field).to eq(:email)
    end

    it "has nil field when not provided" do
      err = ValidationError.new("is blank")
      expect(err.field).to be_nil
    end

    it "can be rescued as a StandardError" do
      expect do
        begin
          raise ValidationError.new("test")
        rescue StandardError
          # caught
        end
      end.not_to raise_error
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: validate_age
  # ----------------------------------------------------------
  describe "#validate_age" do
    it "returns true for a valid age" do
      expect(validate_age(25)).to be true
      expect(validate_age(0)).to be true
      expect(validate_age(100)).to be true
    end

    it "raises ValidationError for a non-Integer" do
      expect { validate_age("old") }.to raise_error(ValidationError)
      expect { validate_age(3.5)   }.to raise_error(ValidationError)
      expect { validate_age(nil)   }.to raise_error(ValidationError)
    end

    it "raises ValidationError for a negative age" do
      expect { validate_age(-1) }.to raise_error(ValidationError)
    end

    it "raises ValidationError for age > 150" do
      expect { validate_age(151) }.to raise_error(ValidationError)
    end

    it "includes field: :age in the error" do
      begin
        validate_age(-1)
      rescue ValidationError => e
        expect(e.field).to eq(:age)
      end
    end

    it "has a descriptive message for type errors" do
      begin
        validate_age("x")
      rescue ValidationError => e
        expect(e.message).to include("Integer")
      end
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: safe_fetch
  # ----------------------------------------------------------
  describe "#safe_fetch" do
    let(:config) { { host: "localhost", port: 5432 } }

    it "returns the value for an existing key" do
      expect(safe_fetch(config, :host)).to eq("localhost")
      expect(safe_fetch(config, :port)).to eq(5432)
    end

    it "returns nil by default for a missing key" do
      expect(safe_fetch(config, :missing)).to be_nil
    end

    it "returns the given default for a missing key" do
      expect(safe_fetch(config, :missing, default: "N/A")).to eq("N/A")
    end

    it "does not raise an error for missing keys" do
      expect { safe_fetch(config, :not_there) }.not_to raise_error
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: with_retry
  # ----------------------------------------------------------
  describe "#with_retry" do
    it "returns the block's value on success" do
      result = with_retry(max_retries: 3) { "success" }
      expect(result).to eq("success")
    end

    it "retries and succeeds when block eventually succeeds" do
      attempts = 0
      result = with_retry(max_retries: 3) do
        attempts += 1
        raise "not yet" if attempts < 3
        "done"
      end
      expect(result).to eq("done")
      expect(attempts).to eq(3)
    end

    it "raises after max_retries are exhausted" do
      expect do
        with_retry(max_retries: 2) { raise "always fails" }
      end.to raise_error(RuntimeError, "always fails")
    end

    it "does not retry for non-RuntimeError exceptions" do
      expect do
        with_retry(max_retries: 5) { raise ArgumentError, "arg error" }
      end.to raise_error(ArgumentError)
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: open_resource (ensure)
  # ----------------------------------------------------------
  describe "#open_resource" do
    before { CLOSED_RESOURCES.clear }

    it "yields to the block" do
      ran = false
      open_resource("test") { ran = true }
      expect(ran).to be true
    end

    it "adds the resource name to CLOSED_RESOURCES after block" do
      open_resource("db") { }
      expect(CLOSED_RESOURCES).to include("db")
    end

    it "closes the resource even when block raises" do
      begin
        open_resource("cache") { raise "error" }
      rescue
        nil
      end
      expect(CLOSED_RESOURCES).to include("cache")
    end

    it "still re-raises the error after closing" do
      expect do
        open_resource("conn") { raise "connection failed" }
      end.to raise_error(RuntimeError, "connection failed")
    end
  end

  # ----------------------------------------------------------
  # Exercise 6: Result
  # ----------------------------------------------------------
  describe "Result" do
    describe ".ok" do
      subject(:result) { Result.ok(42) }

      it "creates a Result" do
        expect(result).to be_a(Result)
      end

      it "is ok?" do
        expect(result.ok?).to be true
      end

      it "is not error?" do
        expect(result.error?).to be false
      end

      it "holds the value" do
        expect(result.value).to eq(42)
      end

      it "has no error" do
        expect(result.error).to be_nil
      end
    end

    describe ".err" do
      subject(:result) { Result.err("not found") }

      it "creates a Result" do
        expect(result).to be_a(Result)
      end

      it "is not ok?" do
        expect(result.ok?).to be false
      end

      it "is error?" do
        expect(result.error?).to be true
      end

      it "holds the error message" do
        expect(result.error).to eq("not found")
      end

      it "has no value" do
        expect(result.value).to be_nil
      end
    end

    describe "#map" do
      it "transforms the value when ok" do
        result = Result.ok(5).map { |v| v * 2 }
        expect(result.ok?).to be true
        expect(result.value).to eq(10)
      end

      it "returns a Result from map" do
        expect(Result.ok(1).map { |v| v + 1 }).to be_a(Result)
      end

      it "does not transform on error — returns self" do
        err_result = Result.err("fail")
        mapped = err_result.map { |v| v * 2 }
        expect(mapped.error?).to be true
        expect(mapped.error).to eq("fail")
      end

      it "chains map calls" do
        result = Result.ok(2)
          .map { |v| v * 3 }
          .map { |v| v + 1 }
        expect(result.value).to eq(7)
      end
    end
  end
end
