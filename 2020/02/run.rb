require_relative "password"

input = File.readlines("input.txt")

passwords = input.map{ |i| Password.new(i) }
puts "Valid legacy passwords: #{passwords.count(&:legacy_valid?)}"
puts "Valid passwords: #{passwords.count(&:valid?)}"
