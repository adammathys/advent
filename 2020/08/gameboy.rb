class Gameboy
  attr_accessor :index, :accumulator

  def initialize(instructions, index = 0, accumulator = 0, seen = Set.new)
    @instructions = instructions
    @index = index
    @accumulator = accumulator
    @seen = seen
  end

  def run(autocorrect = false)
    step(autocorrect) until (@stuck || @success)
    @success
  end

  private

  def step(autocorrect)
    instruction, value = @instructions[index]

    case instruction
    when "acc"
      @accumulator += value.to_i
      @index += 1
    when "jmp"
      if autocorrect
        attempt_swap("nop")
      else
        @index += value.to_i
      end
    when "nop"
      if autocorrect
        attempt_swap("jmp")
      else
        @index += 1
      end
    end

    @success = (index == @instructions.length)
    @stuck = !@seen.add?(@index)
    @accumulator
  end

  def attempt_swap(replacement)
    new_instructions = @instructions.dup
    instruction, value = new_instructions[index]
    new_instructions[index] = [replacement, value]

    other = Gameboy.new(new_instructions, index, accumulator, @seen.dup)
    if other.run
      @index = other.index
      @accumulator = other.accumulator
    else
      case instruction
      when "jmp"
        @index += value.to_i
      when "nop"
        @index += 1
      end
    end
  end
end
