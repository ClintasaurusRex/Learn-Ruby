# frozen_string_literal: true

# ============================================================
# Lesson 09 — Gems and Bundler
# examples.rb — Complete runnable examples
# ============================================================
# Run with:  ruby examples.rb
# (Uses only standard library — no extra gems needed)
# ============================================================

require "json"
require "csv"
require "optparse"
require "tmpdir"
require "fileutils"

puts "=" * 60
puts "LESSON 09: Gems and Bundler"
puts "=" * 60

# ------------------------------------------------------------
# 1. What is a Gem?
# ------------------------------------------------------------
puts "\n--- 1. What is a Gem? ---"

# Gems listed on your system
puts "Ruby version: #{RUBY_VERSION}"
puts "RubyGems version: #{Gem::VERSION}"

# List loaded gems
puts "\nStandard library gems we're using:"
puts "  json  — #{Gem.loaded_specs["json"]&.version || "built-in"}"
puts "  csv   — #{Gem.loaded_specs["csv"]&.version || "built-in"}"

# ------------------------------------------------------------
# 2. require vs require_relative
# ------------------------------------------------------------
puts "\n--- 2. require vs require_relative ---"

# require "name"           — gem or standard library
# require_relative "path"  — local file, path relative to THIS file

puts "require 'json'          — loads from gem path"
puts "require_relative 'lib/formatter' — loads local file"

# Demonstrating require_relative by defining a module inline
# (normally this would be in a separate file)
module Formatter
  def self.header(text)
    separator = "=" * (text.length + 8)
    "#{separator}\n=== #{text} ===\n#{separator}"
  end

  def self.bullet(text)   = "  • #{text}"
  def self.success(text)  = "[OK]    #{text}"
  def self.error(text)    = "[ERROR] #{text}"
  def self.info(text)     = "[INFO]  #{text}"
end

puts Formatter.header("Status Report")
puts Formatter.bullet("Ruby installed")
puts Formatter.success("Tests passing")
puts Formatter.error("Missing config file")
puts Formatter.info("Version 1.2.0")

# ------------------------------------------------------------
# 3. JSON (standard library)
# ------------------------------------------------------------
puts "\n--- 3. JSON standard library ---"

# Ruby → JSON
data = {
  name:   "Alice",
  age:    30,
  active: true,
  scores: [95, 87, 91],
  address: { city: "Austin", state: "TX" }
}

json_str = JSON.generate(data)
puts "Generated: #{json_str.length} chars"

# JSON → Ruby
loaded = JSON.parse(json_str)
puts "Name:   #{loaded["name"]}"
puts "Scores: #{loaded["scores"].inspect}"
puts "City:   #{loaded["address"]["city"]}"

# Pretty print
puts "\nPretty JSON:"
puts JSON.pretty_generate(data)

# Read/write JSON files
tmp = Dir.mktmpdir
at_exit { FileUtils.rm_rf(tmp) }

json_path = File.join(tmp, "config.json")
File.write(json_path, JSON.pretty_generate(data))
restored = JSON.parse(File.read(json_path))
puts "\nRound-trip name: #{restored["name"]}"

# ------------------------------------------------------------
# 4. CSV (standard library)
# ------------------------------------------------------------
puts "\n--- 4. CSV standard library ---"

csv_path = File.join(tmp, "people.csv")

CSV.open(csv_path, "w") do |csv|
  csv << %w[name age city]
  csv << ["Alice", 30, "Austin"]
  csv << ["Bob",   25, "Denver"]
  csv << ["Carol", 35, "Seattle"]
end

people = CSV.read(csv_path, headers: true).map(&:to_h)
puts "Loaded #{people.count} people:"
people.each { |p| puts "  #{p["name"]} (#{p["age"]}) — #{p["city"]}" }

# ------------------------------------------------------------
# 5. Gemfile structure explained
# ------------------------------------------------------------
puts "\n--- 5. Gemfile structure ---"

gemfile_example = <<~GEMFILE
  # frozen_string_literal: true

  source "https://rubygems.org"

  ruby "3.2.0"     # require this Ruby version

  # Core gems (always loaded)
  gem "rspec",     "~> 3.12"   # test framework
  gem "pry",       "~> 0.14"   # debugging REPL
  gem "colorize",  "~> 1.1"    # colored terminal output

  group :development do
    gem "rubocop", "~> 1.60", require: false
  end

  group :test do
    gem "factory_bot", "~> 6.4"
  end
GEMFILE

puts gemfile_example

# ------------------------------------------------------------
# 6. Version constraints explained
# ------------------------------------------------------------
puts "\n--- 6. Version constraints ---"

constraints = [
  ["~> 1.1",   ">= 1.1, < 2.0  (minor version safe)"],
  ["~> 1.1.0", ">= 1.1.0, < 1.2 (patch version safe)"],
  [">= 2.0",   "at least 2.0, no upper bound"],
  ["= 3.12.0", "exactly this version"],
  ["< 2.0",    "any version below 2.0"],
  ["> 1.0, < 3.0", "between 1.0 and 3.0"]
]

puts "Operator".ljust(15) + "Meaning"
puts "-" * 60
constraints.each { |op, meaning| puts op.ljust(15) + meaning }

# ------------------------------------------------------------
# 7. optparse (built-in argument parser)
# ------------------------------------------------------------
puts "\n--- 7. optparse ---"

options = { verbose: false, name: "World", count: 1 }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: ruby script.rb [options]"

  opts.on("-v", "--verbose", "Enable verbose output") do
    options[:verbose] = true
  end

  opts.on("-n", "--name NAME", "Set a name (default: World)") do |n|
    options[:name] = n
  end

  opts.on("-c", "--count N", Integer, "How many times (default: 1)") do |n|
    options[:count] = n
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
  end
end

# Parse a simulated argv (don't use ARGV directly in examples)
parser.parse!(%w[--name Ruby --count 3])

options[:count].times do |i|
  puts "Hello, #{options[:name]}! (#{i + 1}/#{options[:count]})"
end

# ------------------------------------------------------------
# 8. Checking gem availability
# ------------------------------------------------------------
puts "\n--- 8. Checking gem availability ---"

def gem_available?(name)
  Gem::Specification.find_by_name(name)
  true
rescue Gem::MissingSpecError
  false
end

%w[json csv rspec pry colorize nonexistent_gem].each do |name|
  status = gem_available?(name) ? "available" : "not found"
  puts "  #{name.ljust(20)} #{status}"
end

# ------------------------------------------------------------
# 9. Bundler workflow (shown as comments — not runnable without bundler)
# ------------------------------------------------------------
puts "\n--- 9. Bundler commands reference ---"

commands = <<~CMDS
  bundle init              # create a new Gemfile
  bundle install           # install all gems in Gemfile
  bundle update            # update all gems (be careful)
  bundle update rspec      # update just rspec
  bundle exec ruby app.rb  # run with bundled gems
  bundle exec rspec        # run rspec with bundled gems
  bundle list              # list installed gems
  bundle info rspec        # info about a specific gem
  bundle outdated          # show outdated gems
  gem search colorize      # search rubygems.org
  gem install colorize     # install globally (not recommended for apps)
CMDS

puts commands

puts "\n" + "=" * 60
puts "All examples complete!"
puts "=" * 60
