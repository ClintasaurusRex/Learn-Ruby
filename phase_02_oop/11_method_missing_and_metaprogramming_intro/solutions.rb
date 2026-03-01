# frozen_string_literal: true

class SafeConfig
  def initialize
    @settings = {}
  end

  def method_missing(name, *args)
    method = name.to_s

    if method.end_with?("=")
      key = method.delete_suffix("=").to_sym
      @settings[key] = args.first
    elsif @settings.key?(name)
      @settings[name]
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    method = name.to_s
    method.end_with?("=") || @settings.key?(name) || super
  end

  def fetch(key, default = nil)
    @settings.fetch(key.to_sym, default)
  end
end

config = SafeConfig.new
puts "Writers store values dynamically"
config.api_key = "abc123"
puts config.api_key
puts "respond_to? stays accurate"
puts config.respond_to?(:api_key)
puts config.fetch(:missing, "default")
