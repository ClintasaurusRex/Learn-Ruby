# frozen_string_literal: true

class Broadcast
  def call(channel, text)
    raise ArgumentError, "channel must implement #send_message" unless channel.respond_to?(:send_message)

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

class PushNotifier
  def send_message(text)
    "push: #{text}"
  end
end

class BadNotifier
  def ping
    "bad"
  end
end

broadcast = Broadcast.new
puts "Duck typing works with unrelated classes"
puts broadcast.call(EmailNotifier.new, "hello")
puts broadcast.call(SmsNotifier.new, "hello")
puts broadcast.call(PushNotifier.new, "hello")
