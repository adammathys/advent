require "matrix"

class Circuit
  attr_reader :paths

  def initialize(paths)
    @paths = paths.map{ |p| p.split(",") }
  end

  def closest_intersection
    intersections.keys.map { |x| distance(x) }.min
  end

  def fewest_steps
    intersections.values.min
  end

  private

  def distance(a, b = Vector[0,0])
    (a - b).to_a.map(&:abs).sum
  end

  def intersections
    visited_points =
      @paths.map do |steps|
        points = {}
        current = Vector[0,0]

        steps.each do |step|
          direction, magnitude = parse_instruction(step)
          steps = points[current] || 0

          magnitude.times do
            current += direction
            steps += 1

            points[current] ||= steps
          end
        end

        points
      end

    keys = visited_points.map(&:keys).reduce(:&)
    keys.map { |x| [x, visited_points.sum{ |y| y[x] }] }.to_h
  end

  def parse_instruction(instruction)
    direction =
      case instruction[0]
      when 'R'
        Vector[1,0]
      when 'D'
        Vector[0,-1]
      when 'L'
        Vector[-1,0]
      when 'U'
        Vector[0,1]
      end

    magnitude = instruction[1..-1].to_i

    [direction, magnitude]
  end
end
