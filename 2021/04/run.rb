require_relative "bingo"

input = File.readlines("input.txt")
bingo = Bingo.new(input.map(&:chomp))

puts "Winning score: #{bingo.winning_score}"
puts "Losing score: #{bingo.losing_score}"
