require_relative "fuel"

input = File.readlines("input.txt")
result = input.sum do |line|
  Fuel.recursive_required(line.to_i)
end
puts result
