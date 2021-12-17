require_relative "cave"

input = File.readlines("input.txt")
cave = Cave.new(input.map(&:chomp))

puts "Lowest risk: #{cave.lowest_risk(true)}"
