require_relative "sub"

input = File.readlines("input.txt")

position = Sub.move(input)
puts "Final: #{position[0] * position[1]}"
puts "Final (Advanced): #{position[0] * position[2]}"
