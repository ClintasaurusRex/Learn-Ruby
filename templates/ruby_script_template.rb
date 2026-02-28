# frozen_string_literal: true

# =============================================================================
# ruby_script_template.rb
#
# CLI script template with:
#   - OptionParser for command-line flags
#   - Error handling
#   - Dry-run mode
#   - Entry point pattern (only runs when called directly)
# =============================================================================

require "optparse"

# -----------------------------------------------------------------------------
# Script configuration — modify these constants for your script
# -----------------------------------------------------------------------------
SCRIPT_NAME    = "my_script"
SCRIPT_VERSION = "1.0.0"
SCRIPT_SUMMARY = "Does something useful with the given input."

# -----------------------------------------------------------------------------
# Option parsing
# -----------------------------------------------------------------------------
def parse_options(argv)
  options = {
    verbose:  false,
    dry_run:  false,
    output:   nil
  }

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: #{SCRIPT_NAME} [options] <input>"
    opts.separator ""
    opts.separator "#{SCRIPT_SUMMARY}"
    opts.separator ""
    opts.separator "Options:"

    opts.on("-v", "--verbose", "Enable verbose output") do
      options[:verbose] = true
    end

    opts.on("-n", "--dry-run", "Preview changes without applying them") do
      options[:dry_run] = true
    end

    opts.on("-o", "--output FILE", "Write output to FILE") do |file|
      options[:output] = file
    end

    opts.on_tail("-h", "--help", "Show this help message") do
      puts opts
      exit
    end

    opts.on_tail("--version", "Show version") do
      puts "#{SCRIPT_NAME} #{SCRIPT_VERSION}"
      exit
    end
  end

  remaining_args = parser.parse!(argv)
  [options, remaining_args]
rescue OptionParser::InvalidOption => e
  warn "Error: #{e.message}"
  warn "Run '#{SCRIPT_NAME} --help' for usage."
  exit 1
end

# -----------------------------------------------------------------------------
# Core logic — replace this with your actual script logic
# -----------------------------------------------------------------------------
def run(input, options)
  log("Starting #{SCRIPT_NAME}...", options)
  log("Input: #{input}", options)

  if options[:dry_run]
    puts "[DRY RUN] Would process: #{input}"
    return
  end

  # TODO: replace with your logic
  result = process(input, options)

  if options[:output]
    File.write(options[:output], result)
    log("Output written to #{options[:output]}", options)
  else
    puts result
  end
end

def process(input, _options)
  # TODO: replace with your actual processing logic
  "Processed: #{input}"
end

# -----------------------------------------------------------------------------
# Logging helper
# -----------------------------------------------------------------------------
def log(message, options)
  puts "[INFO] #{message}" if options[:verbose]
end

# -----------------------------------------------------------------------------
# Entry point — only runs when script is called directly
# -----------------------------------------------------------------------------
if __FILE__ == $PROGRAM_NAME
  options, args = parse_options(ARGV.dup)

  if args.empty?
    warn "Error: No input provided."
    warn "Run '#{SCRIPT_NAME} --help' for usage."
    exit 1
  end

  begin
    run(args.first, options)
  rescue Interrupt
    warn "\nInterrupted."
    exit 130
  rescue StandardError => e
    warn "Error: #{e.message}"
    warn e.backtrace.first if options[:verbose]
    exit 1
  end
end
