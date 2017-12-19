class Maze
  attr_accessor :visited, :steps

  def initialize(input)
    @maze = input.lines.map { |l| l.gsub("\n", " ").chars }
    @visited = []
    @steps = 0
  end

  def visited
    @visited.join
  end

  def run!
    @visited.clear
    @steps = 0

    current = start
    direction = [0, 1]

    loop do
      x, y = current
      case (char = fetch(x, y))
      when " "
        return
      when "+"
        if direction[0] == 0
          if fetch(x - 1, y) == " "
            unless fetch(x + 1, y) == " "
              direction = [1, 0]
            end
          else
            direction = [-1, 0]
          end
        else
          if fetch(x, y - 1) == " "
            unless fetch(x, y + 1) == " "
              direction = [0, 1]
            end
          else
            direction = [0, -1]
          end
        end
      when /[A-Z]/
        @visited << char
      end

      @steps += 1
      current[0] += direction[0]
      current[1] += direction[1]
    end
  end

  private

  def fetch(x, y)
    @maze.fetch(y, []).fetch(x, " ")
  end

  def start
    [@maze[0].index("|"), 0]
  end
end
