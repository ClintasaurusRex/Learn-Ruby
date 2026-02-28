# frozen_string_literal: true

# ============================================================
# Lesson 03 — Arrays and Hashes
# solutions.rb — Solutions with plain-language explanations
# ============================================================

# ------------------------------------------------------------
# Exercise 1: double_all
# ------------------------------------------------------------
# `map` visits every element and transforms it using the block.
# The block receives one element at a time in `n`.
# It returns a BRAND NEW array — the original is never changed.
# `n * 2` is the last (and only) expression, so it becomes the
# element in the new array at that position.

def double_all(arr)
  arr.map { |n| n * 2 }
end

puts double_all([1, 2, 3]).inspect         # => [2, 4, 6]
puts double_all([0, -5, 10]).inspect       # => [0, -10, 20]
puts double_all([]).inspect                # => []

# ------------------------------------------------------------
# Exercise 2: select_evens
# ------------------------------------------------------------
# `select` keeps only the elements for which the block returns true.
# `n.even?` is Ruby's built-in predicate — it returns true when
# n is divisible by 2 with no remainder.
# Again, `select` returns a new array; the original is unchanged.

def select_evens(arr)
  arr.select { |n| n.even? }
end

puts select_evens([1, 2, 3, 4, 5, 6]).inspect  # => [2, 4, 6]
puts select_evens([1, 3, 5]).inspect            # => []
puts select_evens([2, 4, 6]).inspect            # => [2, 4, 6]

# ------------------------------------------------------------
# Exercise 3: first_long_word
# ------------------------------------------------------------
# `find` (also called `detect`) scans the array from left to right
# and returns the FIRST element for which the block is true.
# If nothing matches, it returns nil — which is exactly what we want.
# This is different from `select`, which would return ALL matches.

def first_long_word(arr)
  arr.find { |str| str.length > 5 }
end

puts first_long_word(["hi", "hello", "elephant"]).inspect  # => "elephant"
puts first_long_word(["cat", "dog", "fox"]).inspect        # => nil
puts first_long_word(["cherry", "banana"]).inspect         # => "cherry"

# ------------------------------------------------------------
# Exercise 4: array_stats
# ------------------------------------------------------------
# Ruby's Array class provides .min, .max, .sum, and .count directly.
# The only subtle point is the average: we call .to_f on the count
# to force Float division. Without it, 7 / 2 => 3 (integer truncation)
# instead of 3.5.
# We return a Hash literal with symbol keys — the conventional Ruby style.

def array_stats(arr)
  {
    min:     arr.min,
    max:     arr.max,
    sum:     arr.sum,
    count:   arr.count,
    average: arr.sum / arr.count.to_f
  }
end

puts array_stats([1, 2, 3, 4, 5]).inspect
# => {:min=>1, :max=>5, :sum=>15, :count=>5, :average=>3.0}
puts array_stats([10, 20, 30]).inspect
# => {:min=>10, :max=>30, :sum=>60, :count=>3, :average=>20.0}

# ------------------------------------------------------------
# Exercise 5: count_occurrences
# ------------------------------------------------------------
# The key insight: a plain `{}` hash returns nil for unknown keys.
# `nil += 1` would raise a NoMethodError.
# `Hash.new(0)` sets the default value to 0, so the first time we
# see a key, `counts[key]` returns 0, and `0 += 1` becomes 1.
# Each subsequent occurrence increments the existing count.
# This is the canonical Ruby counting pattern — memorise it!

def count_occurrences(arr)
  counts = Hash.new(0)
  arr.each { |item| counts[item] += 1 }
  counts
end

puts count_occurrences(["a", "b", "a", "c", "b", "a"]).inspect
# => {"a"=>3, "b"=>2, "c"=>1}
puts count_occurrences(["ruby", "python", "ruby"]).inspect
# => {"ruby"=>2, "python"=>1}
puts count_occurrences([]).inspect
# => {}

# ------------------------------------------------------------
# Exercise 6: extract_field
# ------------------------------------------------------------
# `map` here works on an array of hashes instead of an array of numbers.
# In each iteration `h` is one hash from the array.
# `h[key]` fetches the value for the given key symbol.
# The result is a plain array of just those values — a common
# "pluck" pattern you'll use constantly with database records.

def extract_field(arr_of_hashes, key)
  arr_of_hashes.map { |h| h[key] }
end

users = [{ name: "Alice", age: 30 }, { name: "Bob", age: 25 }]
puts extract_field(users, :name).inspect   # => ["Alice", "Bob"]
puts extract_field(users, :age).inspect    # => [30, 25]

products = [
  { id: 1, price: 9.99  },
  { id: 2, price: 24.99 },
  { id: 3, price: 4.49  }
]
puts extract_field(products, :price).inspect  # => [9.99, 24.99, 4.49]

puts "\nAll solutions verified!"
