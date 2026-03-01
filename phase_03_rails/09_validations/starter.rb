# frozen_string_literal: true

class Signup
  attr_reader :email, :errors

  def initialize(email)
    @email = email
    @errors = []
  end

  def valid?
    errors.clear
    # TODO: check presence
    # TODO: check simple format (contains @)
    errors.empty?
  end
end

signup = Signup.new('')
puts "Valid? #{signup.valid?}"
puts "Errors: #{signup.errors.join(', ')}"
