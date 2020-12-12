require_relative "voyage"

input = File.readlines("input.txt")
voyage = Voyage.new(input)

voyage.simulate
puts "Distance: #{voyage.ship.distance(Vector[0,0])}"

voyage.simulate(true)
puts "Waypoint Distance: #{voyage.ship.distance(Vector[0,0])}"
