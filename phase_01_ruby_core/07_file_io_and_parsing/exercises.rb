# frozen_string_literal: true

# ============================================================
# Lesson 07 — File I/O and Parsing
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise then run:
#   bundle exec rspec test_lesson.rb
# ============================================================

require "csv"
require "json"

# ------------------------------------------------------------
# Exercise 1: word_count
# ------------------------------------------------------------
# Write a method `word_count(text)` that:
# - Accepts a String (not a file path)
# - Splits it into words on whitespace
# - Returns a Hash where each key is a word (downcased)
#   and the value is the number of times it appears
#
# Hint: text.split returns an array of whitespace-delimited words
# Hint: Use Hash.new(0) so missing keys default to 0
# Hint: words.each { |w| counts[w.downcase] += 1 }

def word_count(text)
  # TODO: implement
end

# ------------------------------------------------------------
# Exercise 2: write_and_read_file
# ------------------------------------------------------------
# Write a method `write_lines(path, lines)` that:
# - Takes a file path and an Array of strings
# - Writes each string as its own line using File.open block form
#
# Write a method `read_lines(path)` that:
# - Returns an Array of lines from the file, with newlines stripped
# - Use File.readlines(path, chomp: true)
#
# Hint: File.open(path, "w") { |f| lines.each { |l| f.puts l } }

def write_lines(path, lines)
  # TODO: write each line to the file using block form
end

def read_lines(path)
  # TODO: return an array of lines, stripped of newlines
end

# ------------------------------------------------------------
# Exercise 3: safe_read
# ------------------------------------------------------------
# Write a method `safe_read(path)` that:
# - Returns the file contents as a String if the file exists
# - Returns nil (not an error!) if the file does not exist
#
# Hint: rescue Errno::ENOENT and return nil
# OR: check File.exist?(path) first

def safe_read(path)
  # TODO: implement
end

# ------------------------------------------------------------
# Exercise 4: parse_csv_to_hashes
# ------------------------------------------------------------
# Write a method `parse_csv_to_hashes(csv_string)` that:
# - Accepts a multi-line CSV string (not a file path)
# - Parses it using CSV.parse with headers: true
# - Returns an Array of Hashes
# - Converts any value that looks like an integer to an Integer
#
# Hint: CSV.parse(csv_string, headers: true).map(&:to_h)
# Hint: To convert integers:
#   row.transform_values { |v| v =~ /\A\d+\z/ ? v.to_i : v }

def parse_csv_to_hashes(csv_string)
  # TODO: parse and return array of hashes with integer conversion
end

# ------------------------------------------------------------
# Exercise 5: to_json_string and from_json_string
# ------------------------------------------------------------
# Write a method `to_json_string(data)` that:
# - Converts a Ruby Hash or Array to a JSON string
# - Hint: JSON.generate(data)
#
# Write a method `from_json_string(json_str)` that:
# - Parses a JSON string and returns the Ruby object
# - Hint: JSON.parse(json_str)

def to_json_string(data)
  # TODO: convert to JSON string
end

def from_json_string(json_str)
  # TODO: parse JSON string to Ruby object
end

# ------------------------------------------------------------
# Exercise 6: append_log
# ------------------------------------------------------------
# Write a method `append_log(path, message)` that:
# - Appends a timestamped line to a log file
# - Format: "[YYYY-MM-DD HH:MM:SS] message"
# - Use File.open with "a" mode (append)
# - Use Time.now.strftime("%Y-%m-%d %H:%M:%S") for the timestamp
#
# Hint: File.open(path, "a") { |f| f.puts "[#{timestamp}] #{message}" }

def append_log(path, message)
  # TODO: append a timestamped log line
end
