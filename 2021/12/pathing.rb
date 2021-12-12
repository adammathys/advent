class Pathing
  class Cave
    attr_reader :name, :connections

    def initialize(name)
      @name = name
      @connections = []
    end

    def small?
      @small ||= !@name.match?(/\p{Upper}/)
    end
  end

  class Path
    def initialize(caves = [])
      @caves = caves
    end

    def <<(cave)
      @caves << cave
    end

    def clone
      self.class.new(@caves.clone)
    end

    def disqualify?(twice)
      stats = @caves.select(&:small?).tally
      if twice
        stats.delete(start) != 1 || stats.any?{_2>2} || stats.count{_2>1} > 1
      else
        stats.any?{_2>1}
      end
    end

    private

    def start
      @start ||= @caves.find{_1.name == "start"}
    end
  end

  def initialize(input)
    @caves = {}
    input.each{ add_path(*_1.split(?-)) }
  end

  def paths(twice = false)
    find_paths(@caves["start"], twice).count
  end

  private

  def add_path(a, b)
    @caves[a] = Cave.new(a) unless @caves.key?(a)
    @caves[b] = Cave.new(b) unless @caves.key?(b)

    @caves[a].connections << @caves[b]
    @caves[b].connections << @caves[a]
  end

  def find_paths(cave, twice, visited = Path.new)
    visited << cave

    return if visited.disqualify?(twice)
    return visited if cave.name == "end"

    cave.connections.flat_map{ find_paths(_1, twice, visited.clone) }.compact
  end
end
