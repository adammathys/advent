require_relative "space"

input = File.readlines(__dir__ + "/input.txt").map(&:chomp)

largest = Space.new(input).largest_area()
puts "Largest: #{largest}"

safest = Space.new(input).safe_area(delta: 10_000)
puts "Safest: #{safest}"
