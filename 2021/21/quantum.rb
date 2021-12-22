class Quantum
  DICE = [1, 2, 3]

  def initialize
    @cache = Hash.new
  end

  def simulate(p1_pos, p2_pos, p1_score = 0, p2_score = 0)
    key = [p1_pos, p2_pos, p1_score, p2_score]
    return @cache[key] if @cache[key]

    return [1,0] if p1_score >= 21
    return [0,1] if p2_score >= 21

    p1_total_wins = 0
    p2_total_wins = 0

    possible_rolls.each do |roll, count|
      new_pos = (p1_pos + roll - 1) % 10 + 1
      new_score = p1_score + new_pos

      p2_wins, p1_wins = simulate(p2_pos, new_pos, p2_score, new_score)

      p1_total_wins += p1_wins * count
      p2_total_wins += p2_wins * count
    end

    @cache[key] = [p1_total_wins, p2_total_wins]
  end

  private

  def possible_rolls
    @rolls ||= DICE.product(DICE, DICE).map(&:sum).tally
  end
end
