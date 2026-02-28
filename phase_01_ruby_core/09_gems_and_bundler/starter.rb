# frozen_string_literal: true

# ============================================================
# Lesson 09 — Gems and Bundler
# starter.rb — Working starter code with TODOs and Hints
# ============================================================
# Run this file with:  bundle exec ruby starter.rb
# (Make sure you've run: bundle install first)
# ============================================================

require "json"    # built-in standard library

# ------------------------------------------------------------
# PART 1: Using a built-in "gem" (standard library)
# ------------------------------------------------------------

# JSON is part of Ruby's standard library — no install needed
config = {
  app_name:  "MyTool",
  version:   "1.0.0",
  debug:     false,
  log_level: "info"
}

json_string = JSON.generate(config)
puts "JSON string: #{json_string}"

parsed_back = JSON.parse(json_string)
puts "Parsed version: #{parsed_back["version"]}"

# Pretty print
puts JSON.pretty_generate(config)

# ------------------------------------------------------------
# PART 2: Understanding Gemfile version constraints
# ------------------------------------------------------------

# These are the version constraint styles (for your Gemfile):
#
# gem "rspec", "~> 3.12"    # pessimistic: >= 3.12, < 4.0
# gem "pry",   "~> 0.14"    # pessimistic: >= 0.14, < 1.0
# gem "rake",  ">= 13.0"    # at least 13.0
# gem "json",  "= 2.3.0"    # exactly 2.3.0
#
# TODO: Look at the Gemfile at the root of this repo.
# Question: What gems are included? What are their version constraints?
# Answer below as a comment:
#
# Gems in this project's Gemfile:
# 1. [TODO: fill in]
# 2. [TODO: fill in]
# 3. [TODO: fill in]

# ------------------------------------------------------------
# PART 3: require vs require_relative
# ------------------------------------------------------------

# require "name"         — loads a gem or standard library
# require_relative "path" — loads a LOCAL file relative to this one

# TODO: Create a file called lib/formatter.rb in this lesson folder.
# It should define a module Formatter with these methods:
#   Formatter.header(text) => "=== TEXT ==="
#   Formatter.bullet(text) => "  • text"
#   Formatter.success(text) => "[OK] text"
#   Formatter.error(text)   => "[ERROR] text"
#
# Hint: module Formatter
#         def self.header(text) = "=== #{text.upcase} ==="
#         def self.bullet(text) = "  • #{text}"
#         def self.success(text) = "[OK] #{text}"
#         def self.error(text) = "[ERROR] #{text}"
#       end
#
# Then uncomment and run:
# require_relative "lib/formatter"
# puts Formatter.header("status")
# puts Formatter.bullet("Ruby 3.2 installed")
# puts Formatter.success("All tests pass")

# ------------------------------------------------------------
# PART 4: Using optparse (built-in argument parsing)
# ------------------------------------------------------------

# optparse is a built-in gem for parsing command-line arguments
require "optparse"

# TODO: Build a simple options parser that accepts:
#   -v, --verbose   Enable verbose output
#   -n, --name NAME  Set a name (default: "World")
#   -h, --help       Show help
#
# Hint:
# options = { verbose: false, name: "World" }
# OptionParser.new do |opts|
#   opts.banner = "Usage: ruby starter.rb [options]"
#   opts.on("-v", "--verbose", "Enable verbose output") do
#     options[:verbose] = true
#   end
#   opts.on("-n", "--name NAME", "Set a name") do |name|
#     options[:name] = name
#   end
# end.parse!
#
# puts "Hello, #{options[:name]}!"
# puts "Verbose mode ON" if options[:verbose]

options = { verbose: false, name: "World" }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: bundle exec ruby starter.rb [options]"

  # TODO: Add -v, --verbose option
  # Hint: opts.on("-v", "--verbose", "Enable verbose") { options[:verbose] = true }

  # TODO: Add -n, --name NAME option
  # Hint: opts.on("-n", "--name NAME", "Set name") { |n| options[:name] = n }

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end

parser.parse!(ARGV.dup)   # .dup so we don't modify ARGV in tests

puts "Hello, #{options[:name]}!"
puts "Verbose mode is ON" if options[:verbose]

# ------------------------------------------------------------
# PART 5: gem list — discovering installed gems
# ------------------------------------------------------------

# The following code lists gems available in this project
# (those installed by bundler)
puts "\n=== Project gems ==="
puts "Run: bundle list"
puts "Or:  gem list"

# In Ruby code, you can check if a gem is available:
def gem_available?(name)
  Gem::Specification.find_by_name(name)
  true
rescue Gem::MissingSpecError
  false
end

puts "\nChecking gem availability:"
%w[json rspec pry colorize].each do |gem_name|
  status = gem_available?(gem_name) ? "✓ installed" : "✗ not installed"
  puts "  #{gem_name}: #{status}"
end

# ============================================================
# Run with:  bundle exec ruby starter.rb
# Try:       bundle exec ruby starter.rb --name Ruby --verbose
# ============================================================
