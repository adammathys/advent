class Gameboy
  attr_accessor :idx, :acc

  def initialize(instructions, idx = 0, acc = 0, seen = Set.new)
    @instructions = instructions
    @idx = idx
    @acc = acc
    @seen = seen
  end

  def run(autocorrect = false)
    until (@stuck || @success)
      step(autocorrect)
      @success = (idx == @instructions.length)
      @stuck = !@seen.add?(@idx)
    end
    @success
  end

  private

  def step(autocorrect)
    instruction, value = @instructions[idx]
    case instruction
    when "acc"
      @acc += value.to_i
      @idx += 1
    when "jmp"
      if autocorrect
        attempt_swap(["nop", value])
      else
        @idx += value.to_i
      end
    when "nop"
      if autocorrect
        attempt_swap(["jmp", value])
      else
        @idx += 1
      end
    end
  end

  def attempt_swap(replacement)
    instructions = @instructions.dup
    instructions[idx] = replacement

    other = Gameboy.new(instructions, idx, acc, @seen.dup)
    if other.run
      @idx = other.idx
      @acc = other.acc
    else
      step(false)
    end
  end
end
