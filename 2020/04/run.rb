require_relative "passport"

input = File.read("input.txt").split("\n\n")
passports = input.map { |i| Passport.new(i) }
puts "Valid passports: #{passports.count(&:valid?)}"
