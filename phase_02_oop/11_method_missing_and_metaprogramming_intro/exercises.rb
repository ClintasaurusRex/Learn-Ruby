# frozen_string_literal: true

# Exercise 1: initialize an internal @settings hash.
class SafeConfig
  def initialize
    @settings = {}
  end

  # Exercise 2: support dynamic writers like config.api_key = "abc".
  # Exercise 3: support readers like config.api_key.
  # Exercise 4: call super for unknown methods.
  def method_missing(name, *args)
    super
  end

  # Exercise 5: make respond_to? accurate for dynamic methods.
  def respond_to_missing?(name, include_private = false)
    super
  end
end
