require "pry"
require_relative "intcode"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

puts "---"
puts "BOOST Keycode"
code = Intcode.new(state, 1)
output = []
until (r = code.run)[1]
  output << r[0]
end
print output.join(",")
print "\n"


puts "---"
puts "Distress Signal"
code = Intcode.new(state, 2)
output = []
until (r = code.run)[1]
  output << r[0]
end
print output.join(",")
print "\n"
