require_relative "packet"

input = File.read("input.txt")
packet = Packet.from_hex(input.chomp)

puts "Version sum: #{packet.version_sum}"
puts "Value: #{packet.value}"
