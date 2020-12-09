require_relative "xmas"

input = File.readlines("input.txt")
xmas = Xmas.new(input.map(&:to_i))

puts "Weakness: #{xmas.find_weakness}"
puts "Encryption Weakness: #{xmas.encryption_weakness}"
