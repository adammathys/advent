require_relative "marbles"

game =  Marbles.new(players: 432, rounds: 71_019)
puts "High score: #{game.high_score}"

game =  Marbles.new(players: 432, rounds: 71_019 * 100)
puts "Ultra score: #{game.high_score}"
