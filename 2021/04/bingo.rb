class Bingo
  class Board
    attr_reader :rows

    def initialize(rows)
      @rows = rows.map{_1.split.map(&:to_i)}
      @columns = @rows.transpose
    end

    def won?(seen)
      [*@rows, *@columns].any?{(_1 - seen).empty?}
    end
  end

  def initialize(input)
    @numbers = input[0].split(",").map(&:to_i)
    @boards = input[1..-1].each_slice(6).map do |slice|
      Board.new(slice[1..-1])
    end
  end

  def winning_score
    final_score(winning_board)
  end

  def losing_score
    final_score(losing_board)
  end

  private

  def final_score(board)
    (board.rows.flatten - seen).sum * seen.last
  end

  def seen
    @numbers[0..@last_called]
  end

  def winning_board
    @last_called = 0
    @last_called += 1 until (winning = @boards.find{_1.won?(seen)})
    winning
  end

  def losing_board
    @last_called = 0
    boards = @boards.dup
    while boards.length > 1
      boards.reject!{_1.won?(seen)}
      @last_called += 1
    end
    losing = boards.first
    @last_called += 1 until losing.won?(seen)
    losing
  end
end
