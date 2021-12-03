require_relative "binary"

input = File.readlines("input.txt")

binary = Binary.new(input)

puts "Power consumption: #{binary.gamma * binary.epsilon}"
puts "Life support: #{binary.oxygen * binary.co2}"
