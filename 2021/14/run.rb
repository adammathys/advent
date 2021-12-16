require_relative "polymer"

input = File.readlines("input.txt")
polymer = Polymer.new("PFVKOBSHPSPOOOCOOHBP", input.map(&:chomp))

10.times { polymer.insert }
puts "Difference (10 steps): #{polymer.most_common - polymer.least_common}"

30.times { polymer.insert }
puts "Difference (40 steps): #{polymer.most_common - polymer.least_common}"
