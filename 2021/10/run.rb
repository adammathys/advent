require_relative "subsystem"

input = File.readlines("input.txt")
subsystem = Subsystem.new(input.map(&:chomp))

puts "Illegal score: #{subsystem.corrupted_score}"
puts "Incomplete score: #{subsystem.incomplete_score}"
