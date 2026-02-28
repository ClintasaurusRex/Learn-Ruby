# frozen_string_literal: true

# ============================================================
# Lesson 07 — File I/O and Parsing
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# ============================================================

require "csv"
require "json"
require "tmpdir"
require "fileutils"

# Use a temp dir for all file operations
WORK_DIR = Dir.mktmpdir("lesson07_examples_")
at_exit { FileUtils.rm_rf(WORK_DIR) }

def work(name)
  File.join(WORK_DIR, name)
end

puts "=" * 60
puts "LESSON 07: File I/O and Parsing"
puts "=" * 60

# ------------------------------------------------------------
# 1. Writing Files
# ------------------------------------------------------------
puts "\n--- 1. Writing Files ---"

path = work("demo.txt")

# Simple write (creates or overwrites)
File.write(path, "Hello, World!\n")
puts "Written: #{File.read(path).inspect}"   # => "Hello, World!\n"

# Write with File.open block form
File.open(path, "w") do |f|
  f.puts "Line 1"
  f.puts "Line 2"
  f.puts "Line 3"
end
# File is automatically closed when block exits

# Append mode
File.open(path, "a") do |f|
  f.puts "Line 4 (appended)"
end

puts "After append: #{File.readlines(path, chomp: true).last}"
# => Line 4 (appended)

# ------------------------------------------------------------
# 2. Reading Files
# ------------------------------------------------------------
puts "\n--- 2. Reading Files ---"

content = File.read(path)
puts "Full content length: #{content.length} chars"

# Read into array
lines = File.readlines(path, chomp: true)
puts "Lines: #{lines.length}"
puts "First: #{lines.first}"
puts "Last:  #{lines.last}"

# Read line by line (memory efficient for large files)
puts "Line-by-line:"
File.foreach(path) { |line| print "  #{line}" }
puts

# ------------------------------------------------------------
# 3. File Metadata
# ------------------------------------------------------------
puts "\n--- 3. File Metadata ---"

puts "Exists?     #{File.exist?(path)}"
puts "Size:       #{File.size(path)} bytes"
puts "Readable?   #{File.readable?(path)}"
puts "Directory?  #{File.directory?(path)}"
puts "Basename:   #{File.basename(path)}"
puts "Extname:    #{File.extname(path)}"
puts "Dirname:    #{File.dirname(path)}"

# ------------------------------------------------------------
# 4. CSV
# ------------------------------------------------------------
puts "\n--- 4. CSV ---"

csv_path = work("inventory.csv")

# Write CSV
CSV.open(csv_path, "w") do |csv|
  csv << %w[name quantity price]
  csv << ["Widget",  100, 9.99]
  csv << ["Gadget",  50,  24.99]
  csv << ["Doohickey", 200, 4.49]
end

# Read CSV as array of hashes
items = CSV.read(csv_path, headers: true).map(&:to_h)
puts "Items loaded: #{items.count}"
puts "First item: #{items.first.inspect}"
# => {"name"=>"Widget", "quantity"=>"100", "price"=>"9.99"}

# Type conversion
items.map! do |item|
  item.merge(
    "quantity" => item["quantity"].to_i,
    "price"    => item["price"].to_f
  )
end

total_value = items.sum { |item| item["quantity"] * item["price"] }
puts "Total inventory value: $#{total_value.round(2)}"
# => Total inventory value: $2346.0

# CSV with custom options
tsv_path = work("data.tsv")
CSV.open(tsv_path, "w", col_sep: "\t") do |tsv|
  tsv << ["id", "name"]
  tsv << [1, "Alice"]
  tsv << [2, "Bob"]
end
rows = CSV.read(tsv_path, col_sep: "\t", headers: true).map(&:to_h)
puts "TSV rows: #{rows.inspect}"

# ------------------------------------------------------------
# 5. JSON
# ------------------------------------------------------------
puts "\n--- 5. JSON ---"

json_path = work("config.json")

data = {
  version: "1.2.0",
  debug: false,
  max_retries: 3,
  allowed_hosts: ["localhost", "example.com"],
  database: { host: "localhost", port: 5432 }
}

# Write pretty JSON
File.write(json_path, JSON.pretty_generate(data))
puts "Written JSON:"
puts File.read(json_path)

# Parse JSON
loaded = JSON.parse(File.read(json_path))
puts "Version: #{loaded["version"]}"
puts "DB port: #{loaded["database"]["port"]}"
puts "Hosts:   #{loaded["allowed_hosts"].inspect}"

# JSON array
users_path = work("users.json")
users = [
  { id: 1, name: "Alice", role: "admin" },
  { id: 2, name: "Bob",   role: "user" }
]
File.write(users_path, JSON.generate(users))
loaded_users = JSON.parse(File.read(users_path))
puts "Users count: #{loaded_users.count}"
puts "First user: #{loaded_users.first.inspect}"

# ------------------------------------------------------------
# 6. Error Handling with Files
# ------------------------------------------------------------
puts "\n--- 6. Error Handling ---"

# Safe read — rescue file-not-found
def safe_read(path)
  File.read(path)
rescue Errno::ENOENT
  nil
end

puts safe_read("/no/such/file.txt").inspect   # => nil
puts safe_read(json_path).class               # => String

# Check existence before acting
missing = work("missing.txt")
if File.exist?(missing)
  puts File.read(missing)
else
  puts "File does not exist: #{File.basename(missing)}"
end

# ------------------------------------------------------------
# 7. Word Count (real-world pattern)
# ------------------------------------------------------------
puts "\n--- 7. Word Count Pattern ---"

text_path = work("text.txt")
File.write(text_path, "the quick brown fox jumps over the lazy dog the fox")

counts = Hash.new(0)
File.read(text_path).split.each { |word| counts[word] += 1 }

top = counts.sort_by { |_, v| -v }.first(3)
puts "Top 3 words:"
top.each { |word, count| puts "  #{word}: #{count}" }
# => the: 3, fox: 2, quick: 1

# ------------------------------------------------------------
# 8. CSV → JSON Converter
# ------------------------------------------------------------
puts "\n--- 8. CSV to JSON Converter ---"

source_csv = work("source.csv")
target_json = work("output.json")

CSV.open(source_csv, "w") do |csv|
  csv << %w[name age city]
  csv << ["Alice", 30, "Austin"]
  csv << ["Bob",   25, "Denver"]
end

rows = CSV.read(source_csv, headers: true).map(&:to_h)
File.write(target_json, JSON.pretty_generate(rows))
puts "Converted #{rows.count} rows"
puts File.read(target_json)

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
