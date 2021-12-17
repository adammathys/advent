require_relative "probe"

probe = Probe.new(x: (153..199), y: (-114..-75))

puts "Max Y: #{probe.max_y}"
puts "Count: #{probe.velocities.count}"
