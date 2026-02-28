# frozen_string_literal: true

# ============================================================
# Lesson 07 — File I/O and Parsing
# test_lesson.rb — RSpec tests
# ============================================================
# Run with:  bundle exec rspec test_lesson.rb --format documentation
# ============================================================

require "rspec"
require "tmpdir"
require "fileutils"
require_relative "exercises"

TMP_DIR = Dir.mktmpdir("lesson07_test_")

RSpec.configure do |config|
  config.after(:suite) { FileUtils.rm_rf(TMP_DIR) }
end

def tmp_path(name)
  File.join(TMP_DIR, name)
end

RSpec.describe "Lesson 07: File I/O and Parsing" do
  # ----------------------------------------------------------
  # Exercise 1: word_count
  # ----------------------------------------------------------
  describe "#word_count" do
    it "counts words in a simple string" do
      result = word_count("hello world hello")
      expect(result["hello"]).to eq(2)
      expect(result["world"]).to eq(1)
    end

    it "is case-insensitive" do
      result = word_count("Ruby RUBY ruby")
      expect(result["ruby"]).to eq(3)
    end

    it "returns a Hash" do
      expect(word_count("one two three")).to be_a(Hash)
    end

    it "handles multiple repeated words" do
      result = word_count("the cat sat on the mat the cat")
      expect(result["the"]).to eq(3)
      expect(result["cat"]).to eq(2)
      expect(result["sat"]).to eq(1)
    end

    it "returns correct count for each unique word" do
      result = word_count("a b c a b a")
      expect(result["a"]).to eq(3)
      expect(result["b"]).to eq(2)
      expect(result["c"]).to eq(1)
    end
  end

  # ----------------------------------------------------------
  # Exercise 2: write_lines and read_lines
  # ----------------------------------------------------------
  describe "#write_lines and #read_lines" do
    let(:path) { tmp_path("lines_test.txt") }
    let(:lines) { ["alpha", "beta", "gamma"] }

    before { write_lines(path, lines) }

    it "creates the file" do
      expect(File.exist?(path)).to be true
    end

    it "writes the correct number of lines" do
      expect(File.readlines(path).count).to eq(3)
    end

    it "read_lines returns an Array" do
      expect(read_lines(path)).to be_a(Array)
    end

    it "read_lines returns lines without trailing newlines" do
      expect(read_lines(path)).to eq(["alpha", "beta", "gamma"])
    end

    it "round-trips correctly" do
      data = ["line one", "line two", "line three"]
      path2 = tmp_path("roundtrip.txt")
      write_lines(path2, data)
      expect(read_lines(path2)).to eq(data)
    end
  end

  # ----------------------------------------------------------
  # Exercise 3: safe_read
  # ----------------------------------------------------------
  describe "#safe_read" do
    let(:existing_path) { tmp_path("existing.txt") }

    before { File.write(existing_path, "hello content") }

    it "returns the file contents for an existing file" do
      expect(safe_read(existing_path)).to eq("hello content")
    end

    it "returns nil for a non-existent file" do
      expect(safe_read("/no/such/file/exists.txt")).to be_nil
    end

    it "does not raise an error for missing files" do
      expect { safe_read("/missing/file.txt") }.not_to raise_error
    end
  end

  # ----------------------------------------------------------
  # Exercise 4: parse_csv_to_hashes
  # ----------------------------------------------------------
  describe "#parse_csv_to_hashes" do
    let(:csv) { "name,age,city\nAlice,30,Austin\nBob,25,Denver" }
    let(:result) { parse_csv_to_hashes(csv) }

    it "returns an Array" do
      expect(result).to be_a(Array)
    end

    it "returns the correct number of rows" do
      expect(result.count).to eq(2)
    end

    it "returns Hashes" do
      expect(result.first).to be_a(Hash)
    end

    it "uses headers as keys" do
      expect(result.first.keys).to include("name", "age", "city")
    end

    it "converts integer-like values to Integer" do
      expect(result.first["age"]).to eq(30)
      expect(result.first["age"]).to be_a(Integer)
    end

    it "keeps string values as String" do
      expect(result.first["name"]).to eq("Alice")
      expect(result.first["city"]).to eq("Austin")
    end

    it "parses all rows" do
      expect(result.map { |r| r["name"] }).to eq(["Alice", "Bob"])
    end
  end

  # ----------------------------------------------------------
  # Exercise 5: to_json_string and from_json_string
  # ----------------------------------------------------------
  describe "#to_json_string" do
    it "returns a String" do
      expect(to_json_string({ name: "Alice" })).to be_a(String)
    end

    it "produces valid JSON" do
      json = to_json_string({ name: "Alice", age: 30 })
      expect { JSON.parse(json) }.not_to raise_error
    end

    it "encodes arrays" do
      json = to_json_string([1, 2, 3])
      expect(JSON.parse(json)).to eq([1, 2, 3])
    end
  end

  describe "#from_json_string" do
    it "parses a JSON object to a Hash" do
      result = from_json_string('{"name":"Alice","age":30}')
      expect(result).to be_a(Hash)
      expect(result["name"]).to eq("Alice")
      expect(result["age"]).to eq(30)
    end

    it "parses a JSON array to an Array" do
      result = from_json_string('[1,2,3]')
      expect(result).to eq([1, 2, 3])
    end

    it "round-trips correctly" do
      data = { "name" => "Bob", "scores" => [95, 87] }
      expect(from_json_string(to_json_string(data))).to eq(data)
    end
  end

  # ----------------------------------------------------------
  # Exercise 6: append_log
  # ----------------------------------------------------------
  describe "#append_log" do
    let(:log_path) { tmp_path("test_app.log") }

    it "creates the log file if it does not exist" do
      append_log(log_path, "first message")
      expect(File.exist?(log_path)).to be true
    end

    it "appends a line with the message" do
      append_log(log_path, "test message")
      content = File.read(log_path)
      expect(content).to include("test message")
    end

    it "includes a timestamp in the format [YYYY-MM-DD HH:MM:SS]" do
      append_log(log_path, "timed message")
      content = File.read(log_path)
      expect(content).to match(/\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]/)
    end

    it "appends multiple messages without overwriting" do
      path2 = tmp_path("multi.log")
      append_log(path2, "first")
      append_log(path2, "second")
      append_log(path2, "third")
      lines = File.readlines(path2, chomp: true)
      expect(lines.count).to eq(3)
      expect(lines.any? { |l| l.include?("first") }).to be true
      expect(lines.any? { |l| l.include?("third") }).to be true
    end
  end
end
