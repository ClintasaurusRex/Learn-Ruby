# Lesson 07 — File I/O and Parsing

---

## 1) Concept Overview

File I/O lets your program read from and write to the filesystem.
`File.read` slurps a whole file; `File.foreach` reads line-by-line (memory-efficient).
Always use block form `File.open(path) { |f| ... }` — it closes the file automatically.
Ruby also has built-in support for CSV and JSON parsing.
Parse data → transform in Ruby → write results back.

---

## 2) Mental Model Diagram

```
READING A FILE
──────────────────────────────────────────────────────
Disk                  Ruby
─────                 ──────────────────────────────
file.txt  ──read──►  String       (File.read)
                      Array       (File.readlines)
                      line-by-line (File.foreach)

WRITING A FILE
──────────────────────────────────────────────────────
Ruby                  Disk
──────────────────    ────────
"Hello\n"  ──write──► file.txt   (File.write / "w")
                                  (append with "a")

FILE OPEN MODES
──────────────────────────────────────────────────────
"r"  — read only (default)
"w"  — write, truncate (overwrite)
"a"  — append (add to end)
"r+" — read + write, keep content
"w+" — read + write, truncate

BLOCK FORM (always use this)
──────────────────────────────────────────────────────
File.open("file.txt", "r") do |file|
  file.each_line { |line| puts line }
end
# File is automatically closed when block exits
# Even if an error occurs!
```

---

## 3) Starter Code

```ruby
# frozen_string_literal: true

# Write a file
File.write("hello.txt", "Hello, World!\nLine two.\n")

# Read the whole thing
content = File.read("hello.txt")
puts content

# Read line by line
File.foreach("hello.txt") do |line|
  puts line.chomp   # .chomp removes the trailing newline
end

# Read into array of lines
lines = File.readlines("hello.txt", chomp: true)
puts lines.inspect   # => ["Hello, World!", "Line two."]

# Append to a file
File.open("hello.txt", "a") do |f|
  f.puts "Line three."
end
```

---

## 4) You Type This

Open `starter.rb` and:

1. Write a method `word_count(path)` that reads a file and returns a Hash of `{word => count}`.
2. Write a method `write_report(data, path)` that writes an Array of Hashes to a CSV file.
3. Write a method `parse_csv(path)` that reads back that CSV as an Array of Hashes.
4. Write a method `parse_json_file(path)` that reads a JSON file and returns parsed Ruby objects.

---

## 5) Expand the Example

**CSV parsing with Ruby's standard library:**

```ruby
require "csv"

# Write CSV
CSV.open("people.csv", "w") do |csv|
  csv << ["name", "age", "city"]
  csv << ["Alice", 30, "Austin"]
  csv << ["Bob",   25, "Denver"]
end

# Read CSV as array of hashes
people = CSV.read("people.csv", headers: true).map(&:to_h)
puts people.first.inspect
# => {"name"=>"Alice", "age"=>"30", "city"=>"Austin"}

# Numeric conversion
people.map! { |p| p.merge("age" => p["age"].to_i) }
puts people.first["age"].class   # => Integer
```

**JSON parsing:**

```ruby
require "json"

data = { name: "Alice", scores: [95, 87, 91] }

# Write JSON
File.write("data.json", JSON.pretty_generate(data))

# Read JSON
loaded = JSON.parse(File.read("data.json"))
puts loaded["name"]            # => Alice
puts loaded["scores"].sum      # => 273
```

---

## 6) Real-World Application

> *"How would you use this at work?"*

- **Import data**: read a CSV of customers, validate, insert into database
- **Export reports**: query database, write results to CSV for stakeholders
- **Config files**: read JSON/YAML config files at startup
- **Log parsing**: read log files line-by-line, find ERROR lines, summarize
- **Data transformation**: read CSV in one format, write CSV in another

```ruby
# Real-world: read a log file and count error types
def summarize_errors(log_path)
  counts = Hash.new(0)
  File.foreach(log_path) do |line|
    match = line.match(/\[(\w+)\]/)
    counts[match[1]] += 1 if match
  end
  counts
end
```

---

## 7) Checklist

Before moving on, confirm you can:

- [ ] Read a whole file with `File.read`
- [ ] Read line-by-line with `File.foreach`
- [ ] Read into an array with `File.readlines(path, chomp: true)`
- [ ] Write a file with `File.write` or `File.open("path", "w")`
- [ ] Append to a file with `File.open("path", "a")`
- [ ] Use block form to ensure the file is closed
- [ ] Check if a file exists with `File.exist?`
- [ ] Parse CSV with `require "csv"` and `CSV.read`
- [ ] Parse JSON with `require "json"` and `JSON.parse`
- [ ] Handle `Errno::ENOENT` when a file is not found

---

## 8) Common Mistakes

| Mistake | Fix |
|---------|-----|
| `File.open` without a block — file stays open | Always use block form |
| Writing with `"w"` when you wanted to append | Use `"a"` for append |
| Reading a large file with `File.read` | Use `File.foreach` for large files |
| Forgetting `.chomp` — newlines in strings | Use `chomp: true` or call `.chomp` |
| CSV numbers come back as Strings | Convert with `.to_i` or `.to_f` |
| JSON `require "json"` forgotten | Add `require "json"` at the top |
| Path relative to the wrong directory | Use `File.expand_path` or `__dir__` |

---

## 9) Debug Flow

```
Errno::ENOENT: No such file or directory?
  └─ puts File.exist?("your_file.txt")
  └─ Use File.expand_path("file.txt", __dir__) for relative paths
  └─ Check your working directory: puts Dir.pwd

CSV::MalformedCSVError?
  └─ Open the file in a text editor — look for unescaped commas/quotes
  └─ Try CSV.read(path, liberal_parsing: true)

JSON::ParserError?
  └─ Validate JSON at jsonlint.com (paste contents)
  └─ puts File.read("file.json") to see what you're actually reading

File stays open / resource leak?
  └─ Always use File.open { |f| } block form
  └─ Or use File.read / File.write which handle closing automatically
```

---

## 10) Stretch Goal

Build a mini **CSV → JSON converter**:

```ruby
require "csv"
require "json"

def csv_to_json(csv_path, json_path)
  rows = CSV.read(csv_path, headers: true).map(&:to_h)
  File.write(json_path, JSON.pretty_generate(rows))
  puts "Converted #{rows.count} rows to #{json_path}"
end

csv_to_json("people.csv", "people.json")
```

Extend it: detect numeric columns automatically (if every value in a column can be parsed as a number, convert them all).
