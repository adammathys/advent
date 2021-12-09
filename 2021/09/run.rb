require_relative "lava"

input = File.readlines("input.txt")
lava = Lava.new(input.map(&:chomp))

puts "Risk level: #{lava.risk}"
puts "Basins (largest): #{lava.basins.last(3).inject(:*)}"
