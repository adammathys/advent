require_relative "luggage"

input = File.readlines("input.txt")
luggage = Luggage.new(input)

puts "Can contain shiny gold: #{luggage.count("shiny gold")}"
puts "Required inside: #{luggage.sum("shiny gold")}"
