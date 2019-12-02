class Intcode
  attr_reader :state

  def initialize(state)
    @state = state.dup
  end

  def run(noun = nil, verb = nil)
    state[1] = noun if noun
    state[2] = verb if verb

    idx = 0

    while state[idx] != 99
      x = state[idx + 1]
      y = state[idx + 2]
      z = state[idx + 3]

      case state[idx]
      when 1
        state[z] = state[x] + state[y]
      when 2
        state[z] = state[x] * state[y]
      end

      idx += 4
    end

    state
  end
end
