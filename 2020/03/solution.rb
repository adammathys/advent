require_relative "forest"
require_relative "toboggan"

class Solution
  def initialize(input)
    @forest = Forest.new(input)
  end

  def trees_encountered(slope = Vector[3,1])
    toboggan = Toboggan.new(slope)
    encountered = 0

    while toboggan.pos[1] < @forest.height
      encountered += 1 if @forest.tree?(toboggan.pos)
      toboggan.move!
    end

    encountered
  end

  def arboreal_probability
    slopes = [
      Vector[1,1],
      Vector[3,1],
      Vector[5,1],
      Vector[7,1],
      Vector[1,2]
    ]
    slopes.map { |slope| trees_encountered(slope) }.reduce(&:*)
  end
end
