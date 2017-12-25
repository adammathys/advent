class Turing
  def initialize
    @state = :a
    @tape = Array.new(1, 0)
    @cursor = 0
  end

  def step(n = 1)
    n.times do
      case @state
      when :a
        if @tape[@cursor] == 0
          update(1, 1, :b)
        else
          update(0, -1, :e)
        end
      when :b
        if @tape[@cursor] == 0
          update(1, -1, :c)
        else
          update(0, 1, :a)
        end
      when :c
        if @tape[@cursor] == 0
          update(1, -1, :d)
        else
          update(0, 1, :c)
        end
      when :d
        if @tape[@cursor] == 0
          update(1, -1, :e)
        else
          update(0, -1, :f)
        end
      when :e
        if @tape[@cursor] == 0
          update(1, -1, :a)
        else
          update(1, -1, :c)
        end
      when :f
        if @tape[@cursor] == 0
          update(1, -1, :e)
        else
          update(1, 1, :a)
        end
      end

      if @cursor < 0
        @tape.unshift(0)
        @cursor = 0
      elsif @cursor > (@tape.size - 1)
        @tape.push(0)
      end
    end
  end

  def checksum
    @tape.sum
  end

  private

  def update(value, direction, new_state)
    @tape[@cursor] = value
    @cursor += direction
    @state = new_state
  end
end
