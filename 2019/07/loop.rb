require_relative "intcode"

input = File.read("input.txt")
state = input.chomp.split(",").map(&:to_i)

maximum = [5, 6, 7, 8, 9].permutation.map do |phases|
  amplifiers = phases.map { |phase| Intcode.new(state, phase) }
  loop_max = [0, false]

  until loop_max[1]
    loop_max = amplifiers[4].run do
      amplifiers[3].run do
        amplifiers[2].run do
          amplifiers[1].run do
            amplifiers[0].run { loop_max[0] }[0]
          end[0]
        end[0]
      end[0]
    end
  end

  loop_max[0]
end.max

puts maximum
