# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 11: Method Missing and Metaprogramming Intro" do
  it "writes dynamic values" do
    config = SafeConfig.new
    config.api_key = "abc"
    expect(config.api_key).to eq("abc")
  end

  it "writes multiple keys" do
    config = SafeConfig.new
    config.timeout = 30
    config.retries = 2
    expect(config.timeout).to eq(30)
    expect(config.retries).to eq(2)
  end

  it "raises on unknown read" do
    config = SafeConfig.new
    expect { config.unknown_key }.to raise_error(NoMethodError)
  end

  it "reports dynamic readers in respond_to?" do
    config = SafeConfig.new
    config.api_key = "abc"
    expect(config.respond_to?(:api_key)).to be(true)
  end

  it "reports dynamic writers in respond_to?" do
    expect(SafeConfig.new.respond_to?(:api_key=)).to be(true)
  end
end
