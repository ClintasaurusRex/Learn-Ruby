# frozen_string_literal: true

class TextMessage
  def render
    "TEXT: hello"
  end
end

class EmailMessage
  # TODO: implement render with "EMAIL: hello"
  # Hint: same method name, different output
  def render
    "EMAIL: pending"
  end
end

messages = [TextMessage.new, EmailMessage.new]
messages.each { |message| puts message.render }
