require "matrix"

class Toboggan
  attr_reader :pos

  def initialize(slope = Vector[3,1])
    @pos = Vector[0,0]
    @slope = slope
  end

  def move!
    @pos += @slope
  end
end
