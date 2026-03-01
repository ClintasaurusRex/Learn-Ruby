# frozen_string_literal: true

class Account
  attr_reader :email, :password_digest

  def initialize(email, password)
    @email = email
    @password_digest = ''
    # TODO: set password_digest from password
  end

  def authenticate(password_attempt)
    # TODO: compare digest(password_attempt) with password_digest
  end

  private

  def digest(raw)
    "digest::#{raw.reverse}"
  end
end

account = Account.new('learner@example.com', 'secret123')
puts "Login success? #{account.authenticate('secret123')}"
puts "Login success? #{account.authenticate('wrong')}"
