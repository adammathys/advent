require_relative "droid"

input = File.read("input.txt")
INITIAL_MEMORY = input.chomp.split(",").map(&:to_i)

droid = Droid.new
puts "Optimal path: #{droid.optimal_path}"
puts "Fill time: #{droid.fill_time}"
