require_relative "solution"

input = File.readlines("input.txt")

solution = Solution.new(input)
puts "Trees encountered: #{solution.trees_encountered}"
puts "Probability: #{solution.arboreal_probability}"
