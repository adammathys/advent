class Circuit
  attr_reader :paths

  def initialize(paths)
    @paths = paths
  end

  def closest_intersection
    intersections.keys.map { |x| distance(x, [0,0]) }.min
  end

  def fewest_steps
    intersections.values.min
  end

  private

  def distance(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def intersections
    visited_points =
      @paths.map do |path|
        points = {}
        current = [0,0]

        path.split(",").each do |step|
          direction, magnitude = parse_instruction(step)
          steps = points[current] || 0
          magnitude.times do
            new_location =
              [
                current[0] += direction[0],
                current[1] += direction[1],
              ]
            steps += 1

            unless points.key?(new_location)
              points[new_location] = steps
            end
          end
        end

        points
      end

    keys = visited_points.map(&:keys).reduce(:&)
    keys.map do |x|
      [x, visited_points.sum{ |y| y[x] }]
    end.to_h
  end

  def parse_instruction(instruction)
    direction =
      case instruction[0]
      when 'R'
        [1,0]
      when 'D'
        [0,-1]
      when 'L'
        [-1,0]
      when 'U'
        [0,1]
      end

    magnitude = instruction[1..-1].to_i

    [direction, magnitude]
  end
end
