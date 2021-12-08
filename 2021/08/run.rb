require_relative "display"

input = File.readlines("input.txt")
display = Display.new(input.map(&:chomp))

puts "Count (1, 4, 7, 8): #{display.count(%w[1 4 7 8])}"
puts "Sum: #{display.sum}"
