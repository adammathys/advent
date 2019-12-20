class Intcode
  attr_reader :state, :halted
  alias_method :halted?, :halted

  def initialize(state, input = [])
    @state = state.dup
    @input = input.dup
    @output = []
    @relative_base = 0
    @idx = 0
    @halted = false
  end

  def run
    loop do
      instruction = state[@idx].digits

      x = param(1, instruction[2])
      y = param(2, instruction[3])
      z = index(3, instruction[4])

      case state[@idx] % 100
      when 1
        state[z] = x + y
        @idx += 4
      when 2
        state[z] = x * y
        @idx += 4
      when 3
        x = index(1, instruction[2])
        state[x] = @input.shift
        @idx += 2
      when 4
        @output.push(x)
        @idx += 2
      when 5
        if x != 0
          @idx = y
        else
          @idx += 3
        end
      when 6
        if x == 0
          @idx = y
        else
          @idx += 3
        end
      when 7
        state[z] = (x < y) ? 1 : 0
        @idx += 4
      when 8
        state[z] = (x == y) ? 1 : 0
        @idx += 4
      when 9
        @relative_base += x
        @idx += 2
      when 99
        @halted = true
        return @output
      end
    end
  end

  private

  def param(offset, mode)
    val = state[@idx + offset] || 0

    case mode
    when 0, nil
      state[val] || 0
    when 1
      val
    when 2
      state[val + @relative_base] || 0
    else
      fail
    end
  end

  def index(offset, mode)
    case mode
    when 0, nil
      state[@idx + offset]
    when 2
      state[@idx + offset] + @relative_base
    end
  end
end
