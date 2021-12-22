require_relative "probe"

input = File.read("input.txt").chomp
probe = Probe.new(input)

puts "Beacons: #{probe.count}"
puts "Farthest: #{probe.farthest}"
