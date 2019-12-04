require_relative "circuit"

input = File.readlines("input.txt")
circuit = Circuit.new(input)

puts "CLOSEST: #{circuit.closest_intersection}"
puts "FEWEST: #{circuit.fewest_steps}"
