require_relative "cucumbers"

input = File.readlines("input.txt").map(&:chomp)
cucumbers = Cucumbers.new(input)

puts "Final step: #{cucumbers.move!}"
