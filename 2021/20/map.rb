class Map
  def initialize(key, input)
    @key = key.chars
    @grid = input.map{_1.chars}
    @bit = "."
  end

  def enhance!
    pad!

    new_grid = Array.new(height) { Array.new(width) }

    (0...height).each{ |y|
      (0...width).each{ |x|
        new_grid[y][x] = @key[index(x, y)]
      }
    }

    @bit = @bit == "." ? @key[0] : @key[511]
    @grid = new_grid
  end

  def count
    @grid.sum{_1.count("#")}
  end

  def to_s
    (0...height).map{ |y|
      (0...width).map{ |x|
        @grid[y][x] == "#" ? "#" : " "
      }.join
    }.join("\n")
  end

  private

  def pad!
    @grid.each do |row|
      row.unshift(@bit)
      row.push(@bit)
    end

    @grid.unshift(Array.new(width, @bit))
    @grid.push(Array.new(width, @bit))
  end

  def index(x, y)
    [
      [-1, -1],
      [ 0, -1],
      [ 1, -1],
      [-1,  0],
      [ 0,  0],
      [ 1,  0],
      [-1,  1],
      [ 0,  1],
      [ 1,  1],
    ].map{ |a, b|
      x1, y1 = x + a, y + b
      if (0...width) === x1 && (0...height) === y1
        @grid[y1][x1] == "#" ? "1" : "0"
      else
        @bit == "#" ? "1" : "0"
      end
    }.join.to_i(2)
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end
end
