class Swarm
  def initialize(input)
    @particles = parse_input(input)
  end

  def closest
    1_000.times { move! }
    closest_particle
  end

  def collide
    1_000.times do
      move!
      remove_collisions!
    end
    @particles.size
  end

  private

  def move!
    @particles.each do |_, particle|
      particle[:v] = add_vectors(particle[:v], particle[:a])
      particle[:p] = add_vectors(particle[:p], particle[:v])
    end
  end

  def remove_collisions!
    groups = @particles.keys.group_by do |key|
      @particles[key][:p]
    end
    bad_keys = groups.select do |_, k|
      k.size > 1
    end
    bad_keys.each do |_, k|
      k.each { |x| @particles.delete(x) }
    end
  end

  def closest_particle
    @particles.min_by do |_, p|
      distance(p[:p], [0, 0, 0])
    end.first
  end

  def add_vectors(a, b)
    a.map.with_index { |x, i| x + b[i] }
  end

  def distance(a, b)
    a.map.with_index do |x, i|
      (x - b[i]).abs
    end.sum
  end

  def parse_input(input)
    input.lines.map.with_index do |line, idx|
      metrics = line.split(", ")
      p, v, a = metrics.map { |m| m[3..-2].split(",").map(&:to_i) }
      [idx, { p: p, v: v, a: a }]
    end.to_h
  end
end
