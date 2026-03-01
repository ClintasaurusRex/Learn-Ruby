# frozen_string_literal: true

class TextMessage
  def render
    "TEXT: hello"
  end
end

class EmailMessage
  def render
    "EMAIL: hello"
  end
end

class PushMessage
  def render
    "PUSH: hello"
  end
end

messages = [TextMessage.new, EmailMessage.new, PushMessage.new]
messages.each { |message| puts message.render }
