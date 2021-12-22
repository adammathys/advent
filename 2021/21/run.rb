require_relative "game"
require_relative "quantum"

game = Game.new([7, 2])
game.play!
puts "Answer: #{game.losing_score * game.rolls}"

quantum = Quantum.new
puts "Most wins: #{quantum.simulate(7, 2).max}"
