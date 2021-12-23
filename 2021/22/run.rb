require_relative "reactor"

input = File.readlines("input.txt").map(&:chomp)
reactor = Reactor.new(input)

puts "Cubes on: #{reactor.reboot(limit: [-50,51])}"
puts "Cubes on (no limit): #{reactor.reboot}"
