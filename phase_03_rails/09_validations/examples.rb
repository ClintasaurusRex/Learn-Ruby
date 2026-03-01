# frozen_string_literal: true

class Signup
  attr_reader :email, :errors

  def initialize(email)
    @email = email
    @errors = []
  end

  def valid?
    errors.clear
    errors << "Email can't be blank" if email.strip.empty?
    errors << 'Email format is invalid' unless email.include?('@')
    errors.empty?
  end
end

blank = Signup.new('')
format_bad = Signup.new('nobody-at-example.com')
ok = Signup.new('nobody@example.com')

puts "Blank valid? #{blank.valid?}"
puts "Blank errors: #{blank.errors.join(', ')}"
puts "Format valid? #{format_bad.valid?}"
puts "Format errors: #{format_bad.errors.join(', ')}"
puts "OK valid? #{ok.valid?}"
puts "OK errors: #{ok.errors.join(', ')}"
