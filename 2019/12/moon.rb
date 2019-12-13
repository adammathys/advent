require "matrix"

class Moon
  attr_reader :initial, :position, :velocity

  def initialize(x, y, z)
    @initial = Vector[x,y,z]
    @position = Vector[x,y,z]
    @velocity = Vector[0,0,0]
  end

  def apply_gravity(others)
    others.each do |other|
      other.position.each_with_index do |k, i|
        if position[i] > k
          velocity[i] -= 1
        elsif position[i] < k
          velocity[i] += 1
        end
      end
    end
  end

  def move
    @position += velocity
  end

  def kinetic
    velocity.map(&:abs).sum
  end

  def potential
    position.map(&:abs).sum
  end

  def total_energy
    potential * kinetic
  end

  def returned?(i)
    position[i] == initial[i] && velocity[i] == 0
  end

  def ==(other)
    position == other.position && velocity == other.velocity
  end
end
