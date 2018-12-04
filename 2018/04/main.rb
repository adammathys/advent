require_relative "schedule"

file = File.readlines(__dir__ + "/input.txt").map(&:chomp)

schedule = Schedule.new(file)

guard = schedule.most_asleep()
minute = schedule.best_minute(guard)
puts "Most asleep: #{guard}"
puts "Best minute: #{minute}"
puts "Answer: #{guard * minute}"

guard, minute, occurances = schedule.most_frequent()
puts "Most frequent: #{guard}"
puts "Best minute: #{minute}"
puts "Occurances: #{occurances}"
puts "Answer: #{guard * minute}"
