require_relative "sonar"

input = File.readlines("input.txt")
sonar = Sonar.new(input.map(&:to_i))

puts "Increases: #{sonar.increases}"
puts "Increases (3x): #{sonar.increases(3)}"
