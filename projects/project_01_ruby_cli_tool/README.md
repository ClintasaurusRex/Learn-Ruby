# Project 01: Ruby CLI Tool

## Goal
Build a command-line file transformer that reads text from a file, applies a transformation, and writes output to another file.

## Architecture Diagram (ASCII)

```text
+-------------------+
| Terminal Command  |
| ruby src/cli_tool |
+---------+---------+
          |
          v
+-------------------+       +-------------------+
| OptionParser      | ----> | Config Hash       |
+---------+---------+       +---------+---------+
          |                           |
          v                           v
+-------------------+       +-------------------+
| FileReader        | ----> | Transformer       |
+---------+---------+       +---------+---------+
          |                           |
          v                           v
+-------------------+       +-------------------+
| Error Handling    | <---- | FileWriter        |
+-------------------+       +-------------------+
```

## Design Decisions (Plain Language)
- **OptionParser** keeps argument handling simple and standard for Ruby CLIs.
- **Dry-run mode** prints what would happen without changing files.
- **Small methods** separate reading, transforming, and writing for easier tests.
- **Graceful file errors** return user-friendly messages instead of stack traces.

## How this maps to real-world use
This mirrors tools used in deployment and data-cleanup pipelines where a script must safely process files, preview changes, and fail clearly when input files are missing.

## Step-by-step run instructions (Linux Mint)
1. Open a terminal.
2. Move into this project:
   ```bash
   cd projects/project_01_ruby_cli_tool
   ```
3. Create an input file:
   ```bash
   printf "hello\nworld\n" > sample_input.txt
   ```
4. Run dry-run mode:
   ```bash
   ruby src/cli_tool.rb --input sample_input.txt --output sample_output.txt --mode upcase --dry-run
   ```
5. Run actual write mode:
   ```bash
   ruby src/cli_tool.rb --input sample_input.txt --output sample_output.txt --mode upcase
   ```
6. Run tests (after project gems are available):
   ```bash
   bundle exec rspec tests/cli_tool_spec.rb
   ```

## Sample Output

```text
$ ruby src/cli_tool.rb --input sample_input.txt --output sample_output.txt --mode upcase --dry-run
[DRY RUN] Would read from: sample_input.txt
[DRY RUN] Would write to: sample_output.txt
[DRY RUN] Transformation mode: upcase
[DRY RUN] Preview:
HELLO
WORLD
```
