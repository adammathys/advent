require_relative "orbit"

orbits = File.readlines("input.txt")

model = Orbit.new(orbits)

puts "CHECKSUM: #{model.checksum}"
puts "TRANSFERS: #{model.minimum_transfers("YOU", "SAN")}"
