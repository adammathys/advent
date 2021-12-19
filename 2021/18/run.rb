require_relative "snailfish"

input = File.readlines("input.txt")
fish = input.map{Snailfish.new(_1.chomp)}

puts "Magnitude: #{fish.reduce(:+).magnitude}"

magnitudes = fish.permutation(2).map{ _1.reduce(:+).magnitude }
puts "Largest of any two: #{magnitudes.max}"
