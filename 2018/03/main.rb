require_relative "fabric"

file = File.readlines(__dir__ + "/input.txt").map(&:chomp)

fabric = Fabric.new(file)

puts "Overlap: #{fabric.overlap()}"
puts "Best: #{fabric.best()}"
