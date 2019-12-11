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
    grouped.each do |angle, positions|
      grouped[angle] = sorted(positions, vaporizer)
    end

    angles = rearrange(grouped.keys)

    vaporized = 0
    last_vaporized = nil

    while vaporized < n
      angle = angles[vaporized % angles.length]

      last_vaporized = grouped[angle].shift
      vaporized += 1 if last_vaporized
    end

    last_vaporized
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

  # Sort angles clockwise starting with "up."
  def rearrange(angles)
    sorted = []

    # up -> right
    top_right = angles.select { |a| a <= (Math::PI / 2) && a >= 0 }
    sorted.push(*top_right.sort.reverse)

    # right -> down
    bottom_right = angles.select { |a| a < 0 && a >= (Math::PI / -2) }
    sorted.push(*bottom_right.sort.reverse)

    # down -> left
    bottom_left = angles.select { |a| a < (Math::PI / -2) && a >= -Math::PI }
    sorted.push(*bottom_left.sort.reverse)

    # left -> up
    top_left = angles.select { |a| a <= Math::PI && a > (Math::PI / 2) }
    sorted.push(*top_left.sort.reverse)

    sorted
  end

  # Sort positions from closest to farthest from origin.
  def sorted(positions, origin)
    positions.sort_by do |position|
      distance(position, origin)
    end
  end

  # Using manhattan for simplicity.
  def distance(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def angle(x, y, x2, y2)
    Math.atan2(y - y2, x2 - x)
  end
end
