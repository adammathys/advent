class Orbit
  attr_reader :planets

  def initialize(orbits)
    @planets = {}

    orbits.each do |orbit|
      a, b = orbit.chomp.split(")")

      child = planets.fetch(a, Node.new(a))
      parent = planets.fetch(b, Node.new(b))

      parent.orbits(child)

      planets[a] = child
      planets[b] = parent
    end
  end

  def checksum
    planets.values.sum(&:checksum)
  end

  def minimum_transfers(a, b)
    common_planets = (planets[a].orbitees & planets[b].orbitees)
    common = common_planets.max_by { |x| planets[x].checksum }

    planets[a].checksum(common) + planets[b].checksum(common) - 2
  end

  private

  class Node
    attr_reader :name, :children

    def initialize(name)
      @name = name
      @children = Set.new
    end

    def orbits(node)
      children.add(node)
    end

    def orbitees
      (children.map(&:name) + children.map(&:orbitees)).flatten
    end

    def checksum(root = "COM")
      return 0 if name == root

      children.sum { |c| c.checksum(root) } + children.count
    end
  end
end
