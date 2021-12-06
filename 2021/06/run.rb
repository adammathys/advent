require_relative "lanternfish"

input = File.read("input.txt")
fish = Lanternfish.new(input.chomp)

puts "Count (80 days): #{fish.count(80)}"
puts "Count (256 days): #{fish.count(256)}"
