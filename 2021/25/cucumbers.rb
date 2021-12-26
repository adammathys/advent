class Cucumbers
  def initialize(input)
    @grid = input.map{_1.chars}
  end

  def move!
    steps = 0
    moved = true

    while moved
      moved = false
      steps +=1

      copy = grid_copy

      (0...height).each do |y|
        (0...width).each do |x|
          if @grid[y][x] == ">" && @grid[y][(x+1)%width] == "."
            copy[y][x] = "."
          elsif @grid[y][x] == "." && @grid[y][(x-1)%width] == ">"
            copy[y][x] = ">"
            moved = true
          else
            copy[y][x] = @grid[y][x]
          end
        end
      end

      @grid = copy
      copy = grid_copy

      (0...height).each do |y|
        (0...width).each do |x|
          if @grid[y][x] == "v" && @grid[(y+1)%height][x] == "."
            copy[y][x] = "."
          elsif @grid[y][x] == "." && @grid[(y-1)%height][x] == "v"
            copy[y][x] = "v"
            moved = true
          else
            copy[y][x] = @grid[y][x]
          end
        end
      end

      @grid = copy
    end

    steps
  end

  private

  def grid_copy
    @grid.clone.map(&:clone)
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end
end
