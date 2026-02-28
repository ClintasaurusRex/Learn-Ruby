# frozen_string_literal: true

# ============================================================
# Lesson 09 — Gems and Bundler
# exercises.rb — Guided exercises with hints
# ============================================================
# Complete each exercise then run:
#   bundle exec rspec test_lesson.rb
# ============================================================

require "json"
require "csv"

# ------------------------------------------------------------
# Exercise 1: json_round_trip
# ------------------------------------------------------------
# Write a method `json_round_trip(data)` that:
# - Converts a Ruby Hash or Array to a JSON string
# - Then parses that JSON string back to a Ruby object
# - Returns the parsed Ruby object
#
# Hint: JSON.generate(data) converts to string
# Hint: JSON.parse(json_string) converts back
# Note: Symbol keys become String keys after the round-trip

def json_round_trip(data)
  # TODO: convert to JSON and back
end

# ------------------------------------------------------------
# Exercise 2: parse_json_config
# ------------------------------------------------------------
# Write a method `parse_json_config(json_string)` that:
# - Parses a JSON string
# - Returns a Hash with SYMBOL keys (not string keys)
#
# Hint: JSON.parse(json_string, symbolize_names: true)
#       This converts "name" to :name automatically

def parse_json_config(json_string)
  # TODO: parse with symbolize_names: true
end

# ------------------------------------------------------------
# Exercise 3: build_gemfile_info
# ------------------------------------------------------------
# Write a method `build_gemfile_info(gems)` that:
# - Accepts an Array of Hashes like:
#   [{ name: "rspec", version: "~> 3.12" }, ...]
# - Returns a String in Gemfile format:
#   gem "rspec", "~> 3.12"\ngem "pry", "~> 0.14"\n
#
# Hint: Use .map and .join("\n")
# Hint: Each line looks like: gem "#{g[:name]}", "#{g[:version]}"

def build_gemfile_info(gems)
  # TODO: build the Gemfile gem lines
end

# ------------------------------------------------------------
# Exercise 4: version_constraint_type
# ------------------------------------------------------------
# Write a method `version_constraint_type(constraint)` that:
# - Takes a version constraint string like "~> 3.12"
# - Returns a description:
#   "~> X.Y"   → :pessimistic_minor   (>= X.Y, < X+1)
#   "~> X.Y.Z" → :pessimistic_patch   (>= X.Y.Z, < X.Y+1)
#   ">= X"     → :minimum
#   "= X"      → :exact
#   "< X"      → :maximum
#   anything else → :other
#
# Hint: Use case/when with regex matching
# Hint: /\A~> \d+\.\d+\z/ matches "~> 3.12"
# Hint: /\A~> \d+\.\d+\.\d+\z/ matches "~> 3.12.0"

def version_constraint_type(constraint)
  # TODO: implement using case/when
end

# ------------------------------------------------------------
# Exercise 5: gem_available?
# ------------------------------------------------------------
# Write a method `gem_available?(name)` that:
# - Returns true if the gem is installed and available
# - Returns false if not
# - Does NOT raise an error
#
# Hint: Gem::Specification.find_by_name(name) raises
#       Gem::MissingSpecError if not found
# Hint: rescue Gem::MissingSpecError and return false

def gem_available?(name)
  # TODO: implement
end

# ------------------------------------------------------------
# Exercise 6: parse_csv_string
# ------------------------------------------------------------
# Write a method `parse_csv_string(csv_text, headers: true)` that:
# - Accepts a multi-line CSV string
# - When headers is true: returns Array of Hashes (header row = keys)
# - When headers is false: returns Array of Arrays (all rows including header)
#
# Hint: CSV.parse(csv_text, headers: true).map(&:to_h)
# Hint: CSV.parse(csv_text, headers: false) returns Array of Arrays

def parse_csv_string(csv_text, headers: true)
  # TODO: implement
end
