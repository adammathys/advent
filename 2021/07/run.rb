require_relative "crabs"

input = File.read("input.txt")
crabs = Crabs.new(input.chomp)

puts "Least fuel (constant): #{crabs.min}"
puts "Least fuel: #{crabs.min(false)}"
