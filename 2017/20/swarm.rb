require "matrix"

class Swarm
  def initialize(input)
    @particles = parse_input(input)
  end

  def closest
    500.times { move! }
    @particles.min_by { |_, p| p[:p].r }.first
  end

  def collide
    40.times { move!; remove_collisions! }
    @particles.size
  end

  private

  def move!
    @particles.each do |_, particle|
      particle[:v] += particle[:a]
      particle[:p] += particle[:v]
    end
  end

  def remove_collisions!
    @particles = @particles.group_by { |_, p| p[:p] }.
      select { |_, v| v.size == 1 }.values.flatten(1)
  end

  def parse_input(input)
    input.lines.map.with_index do |line, idx|
      metrics = line.split(", ")
      p, v, a = metrics.map { |m| Vector[*m[3..-2].split(",").map(&:to_i)] }
      [idx, { p: p, v: v, a: a }]
    end.to_h
  end
end
