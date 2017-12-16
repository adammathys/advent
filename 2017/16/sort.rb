class Sort
  def initialize(size, input)
    @programs = ("a".."z").take(size)
    @moves = parse(input)
  end

  def dance(iterations: 1)
    result = @programs.dup
    cycle = find_cycle(result)
    (iterations % cycle).times { iterate(result) }
    result.join
  end

  private

  def parse(moves)
    moves.split(",").map do |move|
      if move[0] == "s"
        [move[0], move[1..-1].to_i]
      else
        v = move[1..-1].split("/")
        v = v.map(&:to_i) if move[0] == "x"
        [move[0], *v]
      end
    end
  end

  def iterate(programs)
    @moves.each do |move|
      case move[0]
      when "s"
        programs.rotate!(-move[1])
      when "x"
        swap(programs, move[1], move[2])
      when "p"
        x = programs.index(move[1])
        y = programs.index(move[2])
        swap(programs, x, y)
      end
    end
    programs
  end

  def find_cycle(programs)
    start = programs.join
    current = programs.dup
    cycle = 1
    cycle += 1 until iterate(current).join == start
    cycle
  end

  def swap(a, x, y)
    a[x], a[y] = a[y], a[x]
  end
end
