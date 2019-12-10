require_relative "astroid_map"

lines = File.readlines("input.txt").map(&:chomp)

astroid_map = AstroidMap.new(lines)

x, y = astroid_map.best_location
puts astroid_map.num_detected(x, y)
