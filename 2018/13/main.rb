require_relative "mine_carts"

input = File.readlines("input.txt")

carts =  MineCarts.new(input)
puts "First crash: #{carts.first_crash}"
puts "Last standing: #{carts.last_standing}"
