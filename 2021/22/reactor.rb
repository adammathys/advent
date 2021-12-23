class Reactor
  Cuboid = Struct.new(:x1, :x2, :y1, :y2, :z1, :z2) do
    def volume
      (x2 - x1) * (y2 - y1) * (z2 - z1)
    end

    def within?(min, max)
      x1 >= min && x2 <= max &&
        y1 >= min && y2 <= max &&
        z1 >= min && z2 <= max
    end

    def overlap?(other)
      x1 < other.x2 && x2 > other.x1 &&
        y1 < other.y2 && y2 > other.y1 &&
        z1 < other.z2 && z2 > other.z1
    end

    def -(other)
      if overlap?(other)
        dx1 = other.x1.clamp(x1, x2)
        dx2 = other.x2.clamp(x1, x2)
        dy1 = other.y1.clamp(y1, y2)
        dy2 = other.y2.clamp(y1, y2)
        dz1 = other.z1.clamp(z1, z2)
        dz2 = other.z2.clamp(z1, z2)

        [
          Cuboid.new(x1,  x2,  y1,  y2,  z1,  dz1), # Bottom
          Cuboid.new(x1,  x2,  y1,  y2,  dz2, z2),  # Top
          Cuboid.new(x1,  dx1, y1,  y2,  dz1, dz2), # Front
          Cuboid.new(dx2, x2,  y1,  y2,  dz1, dz2), # Back
          Cuboid.new(dx1, dx2, dy2, y2,  dz1, dz2), # Right
          Cuboid.new(dx1, dx2, y1,  dy1, dz1, dz2)  # Left
        ].select{_1.volume != 0}
      else
        [self]
      end
    end
  end

  def initialize(instructions)
    @instructions = instructions.map{
      command, ranges = _1.split(" ")
      x, y, z = ranges.split(",")

      x1, x2 = x[2..].split("..").map(&:to_i)
      y1, y2 = y[2..].split("..").map(&:to_i)
      z1, z2 = z[2..].split("..").map(&:to_i)

      cuboid = Cuboid.new(x1, x2+1, y1, y2+1, z1, z2+1)

      [command, cuboid]
    }
  end

  def reboot(limit: nil)
    cuboids = []

    @instructions.each do |command, cuboid|
      cuboids = cuboids.flat_map{_1-cuboid}
      cuboids << cuboid if command == "on"
    end

    cuboids.select!{_1.within?(*limit)} if limit
    cuboids.map(&:volume).sum
  end
end
