# frozen_string_literal: true

# Exercise 1: Build a behavior-based broadcaster.
class Broadcast
  def call(channel, text)
    # TODO: avoid class checks, use shared behavior
    if channel.is_a?(EmailNotifier)
      channel.send_message(text)
    else
      raise ArgumentError, "unsupported channel"
    end
  end
end

# Exercise 2: build first duck.
class EmailNotifier
  def send_message(text)
    "email: #{text}"
  end
end

# Exercise 3: build second duck.
class SmsNotifier
  def send_message(text)
    "sms: #{text}"
  end
end

# Exercise 4: build third duck from unrelated class.
class PushNotifier
  def send_message(text)
    "push: #{text}"
  end
end

# Exercise 5: improve error message when contract is missing.
class BadNotifier
  def ping
    "bad"
  end
end
