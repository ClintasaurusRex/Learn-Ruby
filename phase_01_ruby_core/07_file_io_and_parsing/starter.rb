# frozen_string_literal: true

# ============================================================
# Lesson 07 — File I/O and Parsing
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  ruby starter.rb
# ============================================================

require "csv"
require "json"
require "tmpdir"

# Use a temp directory so we don't litter the repo with test files
WORK_DIR = Dir.mktmpdir("lesson07_")
at_exit { FileUtils.rm_rf(WORK_DIR) }

def work_path(filename)
  File.join(WORK_DIR, filename)
end

# ------------------------------------------------------------
# PART 1: Writing and Reading Files
# ------------------------------------------------------------

# Already works — study this pattern
sample_path = work_path("sample.txt")
File.write(sample_path, "Line one\nLine two\nLine three\n")

puts "=== Read entire file ==="
puts File.read(sample_path)

puts "=== Read line by line ==="
File.foreach(sample_path) do |line|
  puts line.chomp   # .chomp removes trailing newline
end

puts "=== Read into array ==="
lines = File.readlines(sample_path, chomp: true)
puts lines.inspect   # => ["Line one", "Line two", "Line three"]

# ------------------------------------------------------------
# PART 2: Word Count
# ------------------------------------------------------------

# TODO: Write a method `word_count(path)` that:
# - Reads the file at `path`
# - Splits the content into words (use .split)
# - Returns a Hash where each key is a word (downcased) and
#   the value is the number of times it appears
#
# Hint: Use File.read(path) to get the content as a String
# Hint: content.split returns an array of words (splits on whitespace)
# Hint: Use Hash.new(0) as the default hash (auto-starts counts at 0)
# Hint: words.each { |w| counts[w.downcase] += 1 }

def word_count(path)
  # TODO: implement word count
  # Hint:
  # counts = Hash.new(0)
  # File.read(path).split.each { |w| counts[w.downcase] += 1 }
  # counts
end

text_path = work_path("words.txt")
File.write(text_path, "the cat sat on the mat the cat")
counts = word_count(text_path)
puts "\n=== Word Count ==="
puts counts.inspect
# => {"the"=>3, "cat"=>2, "sat"=>1, "on"=>1, "mat"=>1}

# ------------------------------------------------------------
# PART 3: Write and Parse CSV
# ------------------------------------------------------------

people = [
  { name: "Alice", age: 30, city: "Austin" },
  { name: "Bob",   age: 25, city: "Denver" },
  { name: "Carol", age: 35, city: "Seattle" }
]

# TODO: Write a method `write_csv(data, path)` that:
# - Takes an Array of Hashes and a file path
# - Writes a CSV file with headers from the hash keys
# - Then writes each row of values
#
# Hint: Use CSV.open(path, "w") { |csv| ... }
# Hint: Write headers first: csv << data.first.keys
# Hint: Write each row: data.each { |row| csv << row.values }

def write_csv(data, path)
  # TODO: implement CSV writing
end

# TODO: Write a method `parse_csv(path)` that:
# - Reads the CSV file at path
# - Returns an Array of Hashes (use headers: true)
# - Hint: CSV.read(path, headers: true).map(&:to_h)

def parse_csv(path)
  # TODO: implement CSV parsing
end

csv_path = work_path("people.csv")
write_csv(people, csv_path)

parsed = parse_csv(csv_path)
puts "\n=== CSV Round-trip ==="
puts parsed.first.inspect
# => {"name"=>"Alice", "age"=>"30", "city"=>"Austin"}

# ------------------------------------------------------------
# PART 4: JSON Read and Write
# ------------------------------------------------------------

# TODO: Write a method `write_json(data, path)` that:
# - Takes a Ruby object (Hash or Array) and a file path
# - Writes it as pretty-printed JSON
# - Hint: JSON.pretty_generate(data) creates the JSON string
# - Hint: File.write(path, ...) writes the string

def write_json(data, path)
  # TODO: implement JSON writing
end

# TODO: Write a method `read_json(path)` that:
# - Reads a JSON file and returns the parsed Ruby object
# - Hint: JSON.parse(File.read(path))

def read_json(path)
  # TODO: implement JSON reading
end

config = { version: "1.0", debug: false, max_retries: 3, tags: ["ruby", "io"] }
json_path = work_path("config.json")
write_json(config, json_path)

loaded = read_json(json_path)
puts "\n=== JSON Round-trip ==="
puts loaded.inspect
# => {"version"=>"1.0", "debug"=>false, "max_retries"=>3, "tags"=>["ruby", "io"]}

# ------------------------------------------------------------
# PART 5: File existence and safe reading
# ------------------------------------------------------------

# TODO: Write a method `safe_read(path)` that:
# - Returns the file contents if the file exists
# - Returns nil if the file does not exist (do NOT raise an error)
# - Hint: Use File.exist?(path) before reading
# - OR: rescue Errno::ENOENT => e; return nil

def safe_read(path)
  # TODO: implement safe read
end

puts "\n=== Safe Read ==="
puts safe_read(text_path).inspect        # => "the cat sat on the mat the cat"
puts safe_read("/no/such/file").inspect  # => nil

# ============================================================
# Run with:  ruby starter.rb
# ============================================================
