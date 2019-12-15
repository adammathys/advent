require_relative "nanofactory"

input = File.readlines("input.txt")
factory = Nanofactory.new(input)
puts "COST: #{factory.fuel_cost}"
puts "MAX FUEL: #{factory.max_fuel}"
