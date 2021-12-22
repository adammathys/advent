class Game
  class Die
    def initialize
      @values = (1..100).to_a
      @current = 0
    end

    def roll
      @current += 3
      [
        @values[(@current - 3) % 100],
        @values[(@current - 2) % 100],
        @values[(@current - 1) % 100]
      ].sum
    end
  end

  attr_reader :rolls

  def initialize(starts)
    @positions = starts
  end

  def losing_score
    @scores.min
  end

  def play!
    @scores = [0, 0]
    @rolls = 0

    die = Die.new
    positions = @positions.clone

    loop do
      positions[0] = (positions[0] + die.roll - 1) % 10 + 1
      @scores[0] += positions[0]
      @rolls += 3
      break if @scores[0] >= 1000
      
      positions[1] = (positions[1] + die.roll - 1) % 10 + 1
      @scores[1] += positions[1]
      @rolls += 3
      break if @scores[1] >= 1000
    end
  end
end
