require_relative "alu"

instructions = File.readlines("input.txt").map(&:chomp)
alu = Alu.new(instructions)

puts "Largest model number: #{alu.max}"
puts "Smallest model number: #{alu.min}"
