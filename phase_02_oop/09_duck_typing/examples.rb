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

broadcast = Broadcast.new
puts broadcast.call(EmailNotifier.new, "duck typing")
puts broadcast.call(SmsNotifier.new, "duck typing")
puts broadcast.call(PushNotifier.new, "duck typing")
