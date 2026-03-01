# frozen_string_literal: true

require "rspec"

target = ENV.fetch("TARGET", "exercises")
require_relative target

RSpec.describe "Lesson 09: Duck Typing" do
  let(:broadcast) { Broadcast.new }

  it "sends through email notifier" do
    expect(broadcast.call(EmailNotifier.new, "hello")).to eq("email: hello")
  end

  it "sends through sms notifier" do
    expect(broadcast.call(SmsNotifier.new, "hello")).to eq("sms: hello")
  end

  it "sends through push notifier" do
    expect(broadcast.call(PushNotifier.new, "hello")).to eq("push: hello")
  end

  it "raises helpful error when method contract missing" do
    expect { broadcast.call(BadNotifier.new, "hello") }.to raise_error(ArgumentError, /send_message/)
  end

  it "uses behavior checks instead of strict class checks" do
    custom = Class.new do
      def send_message(text)
        "custom: #{text}"
      end
    end
    expect(broadcast.call(custom.new, "hello")).to eq("custom: hello")
  end
end
