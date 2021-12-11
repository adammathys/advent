class Octopi
  def initialize(input)
    @grid = input.map{_1.chars.map(&:to_i)}
  end

  def flashes(steps)
    current_grid = @grid.clone.map(&:clone)
    (0...steps).sum{ simulate_step!(current_grid) }
  end

  def synced_flash
    current_grid = @grid.clone.map(&:clone)
    step = 1
    step +=1 while simulate_step!(current_grid) != (width * height)
    step
  end

  private

  def simulate_step!(grid)
    increase_energy!(grid)

    flashed = []
    (0...height).each do |y|
      (0...width).each do |x|
        next if grid[y][x] <= 9
        next if flashed.include?([x, y])

        flashed << [x, y]
        flash_neighbours!([x, y], flashed, grid)
      end
    end

    reset_flashed!(grid)
    count_flashed(grid)
  end

  def increase_energy!(grid)
    grid.each{ |row| row.each_index{ row[_1] += 1} }
  end

  def reset_flashed!(grid)
    grid.each do |row| 
      row.each_index { row[_1] = 0 if row[_1] > 9 }
    end
  end

  def count_flashed(grid)
    grid.sum{ |row| row.count{_1 == 0} }
  end

  def flash_neighbours!(origin, flashed, grid)
    neighbours(*origin).each do |x, y|
      grid[y][x] += 1

      next if grid[y][x] <= 9
      next if flashed.include?([x, y])

      flashed << [x, y]
      flash_neighbours!([x, y], flashed, grid)
    end
  end

  def neighbours(x, y)
    [
      [-1,  0],
      [-1, -1],
      [ 0, -1],
      [ 1, -1],
      [ 1,  0],
      [ 1,  1],
      [ 0,  1],
      [-1,  1]
    ].map{ |a, b|
      x1, y1 = x + a, y + b
      [x1, y1] if (0...width) === x1 && (0...height) === y1
    }.compact
  end

  def width
    @grid[0].length
  end

  def height
    @grid.length
  end
end
