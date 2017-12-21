class Art
  def initialize(rules)
    @rules = rules.lines.flat_map do |rule|
      pattern, result = rule.split("=>").map(&:strip).map { |s| to_matrix(s) }
      rotated_patterns = []
      4.times do |i|
        pattern = rotate(pattern)
        rotated_patterns << [pattern, result]
        flipped = flip(pattern)
        rotated_patterns << [flipped, result]
      end
      rotated_patterns
    end.to_h

    @start = [
      [".", "#", "."],
      [".", ".", "#"],
      ["#", "#", "#"]
    ]
  end

  def on(iterations)
    grid = @start

    iterations.times do |i|
      sections = split(grid)
      sections = sections.map { |row| row.map{ |r| @rules[r] } }
      grid = stich(sections)
    end

    grid.join.count("#")
  end

  private

  def split(grid)
    sections = []
    slice = (grid.size % 2 == 0) ? 2 : 3
    grid.each_slice(slice) do |rows|
      section_row = []
      0.step(grid.size - 1, slice) do |i|
        section_row << rows.map { |row| row.slice(i, slice) }
      end
      sections << section_row
    end
    sections
  end

  def stich(sections)
    grid = []
    sections.each_with_index do |row, k|
      0.upto(row.size - 1) do |i|
        0.upto(row[0].size - 1) do |j|
          idx = (k * row[0].size) + j
          grid[idx] = [] unless grid[idx]
          grid[idx] += row[i][j]
        end
      end
    end
    grid
  end

  def rotate(matrix)
    matrix.transpose.map(&:reverse)
  end

  def flip(matrix)
    matrix.map(&:reverse)
  end

  def to_matrix(string)
    string.split("/").map(&:chars)
  end
end
