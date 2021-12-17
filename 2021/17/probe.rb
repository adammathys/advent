class Probe
  attr_reader :max_y, :velocities

  def initialize(x:, y:)
    @target_x = x
    @target_y = y
    run_simulations!
  end

  private

  def run_simulations!
    @max_y = 0
    @velocities = []

    (min_yv..max_yv).each do |yv|
      (min_xv..max_xv).each do |xv|
        if (new_max = hits?(xv, yv))
          @velocities << [xv, yv]
          @max_y = [new_max, @max_y].max
        end
      end
    end
  end

  def hits?(xv, yv)
    x = 0
    y = 0
    max_y = 0

    until x > max_xv || y < min_yv
      x += xv
      y += yv

      max_y = [max_y, y].max
      xv = [xv - 1, 0].max
      yv -= 1

      return max_y if @target_x === x && @target_y === y
    end
  end

  def max_xv
    @target_x.last
  end

  def min_xv
    (Math.sqrt(8 * @target_x.first + 1).ceil - 1) / 2
  end

  def max_yv
    min_yv.abs
  end

  def min_yv
    @target_y.first
  end
end
