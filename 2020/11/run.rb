require_relative "seating"

input = File.readlines("input.txt")

seating = Seating.new(input)
puts "Stable: #{seating.stable}"

seating = Seating.new(input)
puts "Stable (ignore floor): #{seating.stable(true)}"
