require "pry"

class AstroidMap
  attr_reader :width, :height, :image

  def initialize(image)
    @width = image.first.length
    @height = image.length

    @image = image.join('').chars
  end

  def best_location
    idx = detected_map.each_with_index.max[1]

    y = idx / height
    x = idx - (y * height)

    [x, y]
  end

  def num_detected(x, y)
    (astroid_positions - [[x,y]]).group_by do |x2, y2|
      angle(x, y, x2, y2)
    end.length
  end

  def nth_vaporized(n)
    vaporizer = best_location

    astroids = astroid_positions - [vaporizer]

    grouped = astroids.group_by do |x2, y2|
      angle(vaporizer[0], vaporizer[1], x2, y2)
    end

    binding.pry
  end

  private

  def detected_map
    @detected_map ||=
      image.map.with_index do |position, idx|
        if position == "#"
          y = idx / height
          x = idx - (y * height)
          num_detected(x, y).to_s
        else
          position
        end
      end
  end

  def astroid_positions
    @positions ||=
      image.map.with_index do |position, idx|
        if position == "#"
          y = idx / height
          x = idx - (y * height)
          [x, y]
        end
      end.compact
  end

  def angle(x, y, x2, y2)
    Math.atan2(y2 - y, x2 - x)
  end
end
