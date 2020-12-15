require_relative "game"

game = Game.new([8,11,0,19,1,2])
puts "Spoken @ 2020: #{game.spoken(2020 - 1)}"
puts "Spoken @ 30000000: #{game.spoken(30000000 - 1)}"
