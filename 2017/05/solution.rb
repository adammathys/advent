class Solution
  class << self
    def call(input, strange: false)
      instructions = input.lines.map(&:to_i)
      position = 0
      steps = 0

      while position >= 0 && position < instructions.size
        jump = instructions[position]
        if strange && jump >= 3
          instructions[position] -= 1
        else
          instructions[position] += 1
        end
        position += jump
        steps += 1
      end

      steps
    end
  end
end
