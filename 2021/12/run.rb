require_relative "pathing"

input = File.readlines("input.txt")
pathing = Pathing.new(input.map(&:chomp))

puts "Paths: #{pathing.paths}"
puts "Paths (twice): #{pathing.paths(true)}"
