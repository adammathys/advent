require_relative "schedule"

input = File.readlines("input.txt")
schedule = Schedule.new(input)
puts "Earliest: #{schedule.earliest}"
puts "Gold Coin: #{schedule.gold_coin}"
