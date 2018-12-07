require_relative "elvish"

input = File.readlines(__dir__ + "/input.txt").map(&:chomp)

sorted = Elvish.new(input).sort()
puts "Sorted: #{sorted}"

time = Elvish.new(input).time(num_workers: 5, base_duration: 60)
puts "Time: #{time}"
