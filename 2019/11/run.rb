require_relative "robot"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

robot = Robot.new(state)
puts "PAINTED: #{robot.run}"
robot.display
