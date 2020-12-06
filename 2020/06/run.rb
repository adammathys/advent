require_relative "group"

input = File.read("input.txt").split("\n\n")

groups = input.map { |i| Group.new(i) }
puts "Sum Any: #{groups.sum(&:count_any)}"
puts "Sum All: #{groups.sum(&:count_all)}"
