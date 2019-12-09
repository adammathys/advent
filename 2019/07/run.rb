require_relative "intcode"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

maximum = [0, 1, 2, 3, 4].permutation.map do |phases|
  Intcode.new(state, phases[4]).run do
    Intcode.new(state, phases[3]).run do
      Intcode.new(state, phases[2]).run do
        Intcode.new(state, phases[1]).run do
          Intcode.new(state, phases[0]).run do
            0
          end[0]
        end[0]
      end[0]
    end[0]
  end[0]
end.max
puts maximum
