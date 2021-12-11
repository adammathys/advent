require_relative "octopi"

input = File.readlines("input.txt")
octopi = Octopi.new(input.map(&:chomp))

puts "Flashes (100 steps): #{octopi.flashes(100)}"
puts "Synchronized on step: #{octopi.synced_flash}"
