require_relative "vents"

input = File.readlines("input.txt")
vents = Vents.new(input.map(&:chomp))

puts "Overlap (No diagonals): #{vents.overlaps}"
puts "Overlap (With diagonals): #{vents.overlaps(true)}"
