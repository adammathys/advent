class Solution
  def initialize(input)
    @directions = input.strip.split(",")
  end

  def walk(farthest: false)
    origin = [0, 0, 0]
    current = origin.dup
    max = 0

    @directions.each do |direction|
      current = move(current, direction)
      steps = distance(origin, current)
      max = steps if max < steps
    end

    if farthest
      max
    else
      distance(origin, current)
    end
  end

  private

  def move(origin, direction)
    case direction
    when "n"
      origin[1] += 1
      origin[2] -= 1
    when "ne"
      origin[0] += 1
      origin[2] -= 1
    when "se"
      origin[0] += 1
      origin[1] -= 1
    when "s"
      origin[1] -= 1
      origin[2] += 1
    when "sw"
      origin[0] -= 1
      origin[2] += 1
    when "nw"
      origin[0] -= 1
      origin[1] += 1
    end
    origin
  end

  def distance(origin, current)
    origin.map.with_index do |v, i|
      (v - current[i]).abs
    end.max
  end
end
