# frozen_string_literal: true

# ============================================================
# Lesson 07 — File I/O and Parsing
# solutions.rb — Solutions with plain-language explanations
# ============================================================

require "csv"
require "json"

# ------------------------------------------------------------
# Exercise 1: word_count
# ------------------------------------------------------------
# Hash.new(0) is the key pattern: it creates a hash where
# any missing key defaults to 0 instead of nil.
# This means counts[word] += 1 works even on first encounter.
# We downcase everything for case-insensitive matching.

def word_count(text)
  counts = Hash.new(0)
  text.split.each { |word| counts[word.downcase] += 1 }
  counts
end

puts word_count("the cat sat on the mat the cat").inspect
# => {"the"=>3, "cat"=>2, "sat"=>1, "on"=>1, "mat"=>1}

# ------------------------------------------------------------
# Exercise 2: write_lines and read_lines
# ------------------------------------------------------------
# Block form of File.open guarantees the file is closed even
# if an error occurs — safer than f = File.open / f.close.
# File.readlines(path, chomp: true) strips \n from each line
# so we get clean strings without having to call .chomp manually.

require "tmpdir"
require "fileutils"

TMP = Dir.mktmpdir("lesson07_sol_")
at_exit { FileUtils.rm_rf(TMP) }

def tmp(name) = File.join(TMP, name)

def write_lines(path, lines)
  File.open(path, "w") { |f| lines.each { |l| f.puts l } }
end

def read_lines(path)
  File.readlines(path, chomp: true)
end

write_lines(tmp("lines.txt"), ["alpha", "beta", "gamma"])
puts read_lines(tmp("lines.txt")).inspect   # => ["alpha", "beta", "gamma"]

# ------------------------------------------------------------
# Exercise 3: safe_read
# ------------------------------------------------------------
# Rescuing Errno::ENOENT is the Ruby way to handle missing files.
# Returning nil is better than crashing: callers can check for nil
# and decide what to do. Calling code should not wrap this method in
# additional rescue blocks when it already handles errors gracefully.

def safe_read(path)
  File.read(path)
rescue Errno::ENOENT
  nil
end

write_lines(tmp("exists.txt"), ["hello"])
puts safe_read(tmp("exists.txt")).inspect       # => "hello\n"
puts safe_read("/absolutely/no/such/file").inspect # => nil

# ------------------------------------------------------------
# Exercise 4: parse_csv_to_hashes
# ------------------------------------------------------------
# CSV.parse works on a String (not a file).
# headers: true uses the first row as column names.
# .map(&:to_h) converts each CSV::Row to a plain Ruby Hash.
# The transform_values block detects integer-like strings and
# converts them, keeping other values as strings.

def parse_csv_to_hashes(csv_string)
  CSV.parse(csv_string, headers: true).map do |row|
    row.to_h.transform_values do |v|
      v =~ /\A\d+\z/ ? v.to_i : v
    end
  end
end

csv = "name,age,city\nAlice,30,Austin\nBob,25,Denver"
rows = parse_csv_to_hashes(csv)
puts rows.first.inspect
# => {"name"=>"Alice", "age"=>30, "city"=>"Austin"}
puts rows.first["age"].class   # => Integer

# ------------------------------------------------------------
# Exercise 5: to_json_string and from_json_string
# ------------------------------------------------------------
# JSON.generate converts Ruby objects to a JSON string.
# JSON.parse converts a JSON string back to Ruby objects.
# Note: Symbol keys become String keys after the round-trip —
# { name: "Alice" } becomes { "name" => "Alice" }.
# This is normal JSON behavior.

def to_json_string(data)
  JSON.generate(data)
end

def from_json_string(json_str)
  JSON.parse(json_str)
end

original = { name: "Alice", scores: [95, 87, 91], active: true }
json = to_json_string(original)
puts json
# => {"name":"Alice","scores":[95,87,91],"active":true}

restored = from_json_string(json)
puts restored["name"]
# => Alice
puts restored["scores"].sum
# => 273

# ------------------------------------------------------------
# Exercise 6: append_log
# ------------------------------------------------------------
# "a" mode opens the file for appending — it never erases
# existing content. If the file doesn't exist yet, "a" creates it.
# strftime formats Time.now into a human-readable timestamp.

def append_log(path, message)
  timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  File.open(path, "a") { |f| f.puts "[#{timestamp}] #{message}" }
end

log_path = tmp("app.log")
append_log(log_path, "Application started")
append_log(log_path, "User Alice logged in")
append_log(log_path, "User Alice logged out")

puts read_lines(log_path).map { |l| l.split("] ").last }.inspect
# => ["Application started", "User Alice logged in", "User Alice logged out"]
