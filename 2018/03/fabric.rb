class Fabric
  def initialize(input, size: 1_000)
    @input = input
    @size = size

    process_claims
  end
  
  def overlap
    @grid.sum { |x| x.count{ |y| y.length > 1 } }
  end

  def best
    @possible_bests.first
  end

  private

  def process_claims
    @grid = Array.new(@size) { Array.new(@size) { Array.new } }
    @possible_bests = []
    @input.each do |claim|
      num, position = claim.split("@")
      start, area = position.split(":")
      x, y =  start.split(",").map(&:to_i)
      w, h =  area.split("x").map(&:to_i)
      num = num.gsub("#", "").to_i

      @possible_bests << num

      x.upto(x + w - 1) do |i|
        y.upto(y + h - 1) do |j|
          @grid[i][j] << num
          @possible_bests -= @grid[i][j] if @grid[i][j].length > 1
        end
      end
    end
  end
end
