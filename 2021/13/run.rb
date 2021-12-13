require_relative "origami"

input = File.readlines("input.txt")
origami = Origami.new(input.map(&:chomp))

puts "Visible after first fold: #{origami.fold(x: 655).count}"

origami.fold(y: 447)
origami.fold(x: 327)
origami.fold(y: 223)
origami.fold(x: 163)
origami.fold(y: 111)
origami.fold(x: 81)
origami.fold(y: 55)
origami.fold(x: 40)
origami.fold(y: 27)
origami.fold(y: 13)
origami.fold(y: 6)

puts "Activation code:"
puts origami
