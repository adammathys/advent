require_relative "intcode"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

code = Intcode.new(state)
code.run(5)
