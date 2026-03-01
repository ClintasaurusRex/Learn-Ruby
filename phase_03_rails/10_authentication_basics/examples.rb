# frozen_string_literal: true

class Account
  attr_reader :email, :password_digest

  def initialize(email, password)
    @email = email
    @password_digest = digest(password)
  end

  def authenticate(password_attempt)
    digest(password_attempt) == password_digest
  end

  private

  def digest(raw)
    "digest::#{raw.reverse}"
  end
end

class SessionsController
  def initialize(accounts)
    @accounts = accounts
    @session = {}
  end

  def login(email, password)
    account = @accounts.find { |candidate| candidate.email == email }
    return false unless account&.authenticate(password)

    @session[:current_user_email] = account.email
    true
  end

  def logout
    @session.delete(:current_user_email)
  end

  def current_user_email
    @session[:current_user_email]
  end
end

accounts = [Account.new('learner@example.com', 'secret123')]
controller = SessionsController.new(accounts)

puts "Login success? #{controller.login('learner@example.com', 'secret123')}"
puts "Current user: #{controller.current_user_email}"
puts "Login success? #{controller.login('learner@example.com', 'wrong')}"
controller.logout
puts "Current user after logout: #{controller.current_user_email.inspect}"
