# frozen_string_literal: true

require 'optparse'

class CliTool
  def self.run(argv = ARGV)
    config = { mode: 'upcase', dry_run: false }

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ruby src/cli_tool.rb --input file --output file [--mode upcase|downcase] [--dry-run]'
      opts.on('--input PATH', 'Input file path') { |v| config[:input] = v }
      opts.on('--output PATH', 'Output file path') { |v| config[:output] = v }
      opts.on('--mode MODE', 'Transform mode: upcase or downcase') { |v| config[:mode] = v }
      opts.on('--dry-run', 'Preview output without writing') { config[:dry_run] = true }
    end

    parser.parse!(argv)

    unless config[:input] && config[:output]
      puts parser.banner
      return 1
    end

    text = read_file(config[:input])
    return 1 unless text

    transformed = transform(text, config[:mode])

    if config[:dry_run]
      puts "[DRY RUN] Would read from: #{config[:input]}"
      puts "[DRY RUN] Would write to: #{config[:output]}"
      puts "[DRY RUN] Transformation mode: #{config[:mode]}"
      puts "[DRY RUN] Preview:"
      puts transformed
      return 0
    end

    write_file(config[:output], transformed)
    0
  end

  def self.read_file(path)
    File.read(path)
  rescue Errno::ENOENT
    warn "Error: input file not found: #{path}"
    nil
  rescue StandardError => e
    warn "Error: could not read input file: #{e.message}"
    nil
  end

  def self.write_file(path, content)
    File.write(path, content)
  rescue StandardError => e
    warn "Error: could not write output file: #{e.message}"
    1
  end

  def self.transform(text, mode)
    case mode
    when 'upcase' then text.upcase
    when 'downcase' then text.downcase
    else text
    end
  end
end

exit(CliTool.run) if $PROGRAM_NAME == __FILE__
