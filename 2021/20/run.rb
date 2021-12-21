require_relative "map"

key = File.read("key.txt").chomp
input = File.readlines("input.txt").map(&:chomp)

map = Map.new(key, input)

2.times { map.enhance! }
puts "Pixels (2 iterations): #{map.count}"

48.times { map.enhance! }
puts "Pixels (50 iterations): #{map.count}"
