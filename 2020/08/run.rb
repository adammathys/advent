require_relative "gameboy"

input = File.readlines("input.txt")
gameboy = Gameboy.new(input.map{ |i| i.split(' ') })

gameboy.run(true)
puts "Result: #{gameboy.accumulator}"
