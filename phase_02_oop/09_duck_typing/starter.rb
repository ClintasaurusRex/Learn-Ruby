# frozen_string_literal: true

class Broadcast
  def call(channel, text)
    # TODO: call a shared method on any channel object
    # Hint: send_message is the contract
    channel.send_message(text)
  end
end

class EmailNotifier
  def send_message(text)
    "email: #{text}"
  end
end

class SmsNotifier
  def send_message(text)
    "sms: #{text}"
  end
end

puts Broadcast.new.call(EmailNotifier.new, "hello")
puts Broadcast.new.call(SmsNotifier.new, "hello")
