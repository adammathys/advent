class Intcode
  attr_reader :state

  def initialize(state)
    @state = state.dup
  end

  def run(input)
    idx = 0

    while state[idx] != 99
      instruction = state[idx].digits

      x = state[idx + 1]
      x = state[x] unless instruction[2] == 1

      # Not always used, but just in case.
      y = state[idx + 2]
      y = state[y] unless instruction[3] == 1

      case instruction[0]
      when 1
        state[state[idx + 3]] = x + y
        idx += 4
      when 2
        state[state[idx + 3]] = x * y
        idx += 4
      when 3
        state[state[idx + 1]] = input
        idx += 2
      when 4
        if x == 0
          print "."
        else
          print x
        end
        idx += 2
      when 5
        if x != 0
          idx = y
        else
          idx += 3
        end
      when 6
        if x == 0
          idx = y
        else
          idx += 3
        end
      when 7
        state[state[idx + 3]] = (x < y) ? 1 : 0
        idx += 4
      when 8
        state[state[idx + 3]] = (x == y) ? 1 : 0
        idx += 4
      end
    end

    print "\n"
    state
  end
end
