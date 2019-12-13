require_relative "game"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

# Play for free
state[0] = 2

game = Game.new(state)
puts game.run
