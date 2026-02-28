# frozen_string_literal: true

# ============================================================
# Lesson 09 — Gems and Bundler
# solutions.rb — Solutions with plain-language explanations
# ============================================================

require "json"
require "csv"

# ------------------------------------------------------------
# Exercise 1: json_round_trip
# ------------------------------------------------------------
# This exercise demonstrates the full JSON round-trip.
# JSON.generate converts Ruby to a JSON string.
# JSON.parse converts a JSON string back to Ruby objects.
# Important: Symbol keys (:name) become String keys ("name")
# after JSON — this is a standard JSON behavior, not a bug.

def json_round_trip(data)
  json_string = JSON.generate(data)
  JSON.parse(json_string)
end

original = { name: "Alice", age: 30, active: true }
restored = json_round_trip(original)
puts restored.inspect
# => {"name"=>"Alice", "age"=>30, "active"=>true}
puts restored["name"]   # => Alice
puts restored.keys.map(&:class).uniq.inspect   # => [String]

# ------------------------------------------------------------
# Exercise 2: parse_json_config
# ------------------------------------------------------------
# symbolize_names: true is a convenient option that automatically
# converts all string keys to symbols during parsing.
# This means you can use config[:name] instead of config["name"].
# It's particularly useful for configuration objects where you
# want Ruby-style access to the keys.

def parse_json_config(json_string)
  JSON.parse(json_string, symbolize_names: true)
end

json = '{"host":"localhost","port":5432,"debug":false}'
config = parse_json_config(json)
puts config.inspect
# => {:host=>"localhost", :port=>5432, :debug=>false}
puts config[:host]   # => localhost
puts config[:port]   # => 5432

# ------------------------------------------------------------
# Exercise 3: build_gemfile_info
# ------------------------------------------------------------
# We map over the gems array and format each entry as a Gemfile line.
# join("\n") puts each line on its own row.
# The trailing newline from puts makes it look like a real Gemfile section.

def build_gemfile_info(gems)
  gems.map { |g| %(gem "#{g[:name]}", "#{g[:version]}") }.join("\n")
end

gems = [
  { name: "rspec",    version: "~> 3.12" },
  { name: "pry",      version: "~> 0.14" },
  { name: "colorize", version: "~> 1.1" }
]
puts build_gemfile_info(gems)
# gem "rspec", "~> 3.12"
# gem "pry", "~> 0.14"
# gem "colorize", "~> 1.1"

# ------------------------------------------------------------
# Exercise 4: version_constraint_type
# ------------------------------------------------------------
# We use a case statement with regex patterns to classify the constraint.
# The order matters: check the more specific 3-part pessimistic first,
# then the 2-part pessimistic, then the simpler operators.

def version_constraint_type(constraint)
  case constraint
  when /\A~> \d+\.\d+\.\d+\z/ then :pessimistic_patch
  when /\A~> \d+\.\d+\z/      then :pessimistic_minor
  when /\A>= /                  then :minimum
  when /\A= /                   then :exact
  when /\A< /                   then :maximum
  else                               :other
  end
end

puts version_constraint_type("~> 3.12")     # => pessimistic_minor
puts version_constraint_type("~> 3.12.0")   # => pessimistic_patch
puts version_constraint_type(">= 2.0")      # => minimum
puts version_constraint_type("= 1.0.0")     # => exact
puts version_constraint_type("< 3.0")       # => maximum
puts version_constraint_type("> 1.0")       # => other

# ------------------------------------------------------------
# Exercise 5: gem_available?
# ------------------------------------------------------------
# Gem::Specification.find_by_name raises Gem::MissingSpecError
# when the gem is not installed. We rescue that and return false.
# This is the correct pattern for "optional gem" checking —
# don't use require and rescue LoadError in production code.

def gem_available?(name)
  Gem::Specification.find_by_name(name)
  true
rescue Gem::MissingSpecError
  false
end

puts gem_available?("json")           # => true (always available)
puts gem_available?("rspec")          # => true or false depending on install
puts gem_available?("nonexistent_xyz") # => false

# ------------------------------------------------------------
# Exercise 6: parse_csv_string
# ------------------------------------------------------------
# CSV.parse works on String input (not files).
# With headers: true, the first row becomes column names.
# .map(&:to_h) converts each CSV::Row to a plain Ruby Hash.
# Without headers, we get raw Arrays — including the header row.

def parse_csv_string(csv_text, headers: true)
  if headers
    CSV.parse(csv_text, headers: true).map(&:to_h)
  else
    CSV.parse(csv_text, headers: false)
  end
end

csv = "name,age,city\nAlice,30,Austin\nBob,25,Denver"

with_headers = parse_csv_string(csv)
puts "With headers:"
puts with_headers.first.inspect
# => {"name"=>"Alice", "age"=>"30", "city"=>"Austin"}

without_headers = parse_csv_string(csv, headers: false)
puts "\nWithout headers:"
puts without_headers.inspect
# => [["name", "age", "city"], ["Alice", "30", "Austin"], ["Bob", "25", "Denver"]]
