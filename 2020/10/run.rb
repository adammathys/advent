require_relative "adapter"

input = File.readlines("input.txt")
adapter = Adapter.new(input.map(&:to_i))

puts "Differences: #{adapter.jolt_differences.reduce(&:*)}"
puts "Arrangements: #{adapter.arrangements}"
