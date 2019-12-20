require_relative "ascii"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

ascii = Ascii.new(state)
#ascii.display
puts ascii.graph.alignment_sum

instructions = [
  "A,A,B,C,C,A,B,C,A,B",
  "L,12,L,12,R,12",
  "L,8,L,8,R,12,L,8,L,8",
  "L,10,R,8,R,12",
  "n"
].map { |x| x.chars.map(&:ord) + [10] }.flatten

puts ascii.dust_collected(instructions)
