class Intcode
  attr_reader :state

  def initialize(state, phase)
    @state = state.dup
    @input = phase
    @output = nil
    @idx = 0
  end

  def run
    loop do
      instruction = state[@idx].digits

      x = state[@idx + 1]
      x = state[x] unless x.nil? || instruction[2] == 1

      # Not always used, but just in case.
      y = state[@idx + 2]
      y = state[y] unless y.nil? || instruction[3] == 1

      case state[@idx] % 100
      when 1
        state[state[@idx + 3]] = x + y
        @idx += 4
      when 2
        state[state[@idx + 3]] = x * y
        @idx += 4
      when 3
        @input ||= yield
        state[state[@idx + 1]] = @input
        @input = nil
        @idx += 2
      when 4
        @output = x
        @idx += 2
        return [x, false]
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
        state[state[@idx + 3]] = (x < y) ? 1 : 0
        @idx += 4
      when 8
        state[state[@idx + 3]] = (x == y) ? 1 : 0
        @idx += 4
      when 99
        return [@output, true]
      end
    end
  end
end
