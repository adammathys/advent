require "matrix"
require "set"

class Probe
  ROTATION_MATRICES = [
    Matrix[[1,0,0],[0,1,0],[0,0,1]],
    Matrix[[1,0,0],[0,0,-1],[0,1,0]],
    Matrix[[1,0,0],[0,-1,0],[0,0,-1]],
    Matrix[[1,0,0],[0,0,1],[0,-1,0]],

    Matrix[[0,-1,0],[1,0,0],[0,0,1]],
    Matrix[[0,0,1],[1,0,0],[0,1,0]],
    Matrix[[0,1,0],[1,0,0],[0,0,-1]],
    Matrix[[0,0,-1],[1,0,0],[0,-1,0]],

    Matrix[[-1,0,0],[0,-1,0],[0,0,1]],
    Matrix[[-1,0,0],[0,0,-1],[0,-1,0]],
    Matrix[[-1,0,0],[0,1,0],[0,0,-1]],
    Matrix[[-1,0,0],[0,0,1],[0,1,0]],

    Matrix[[0,1,0],[-1,0,0],[0,0,1]],
    Matrix[[0,0,1],[-1,0,0],[0,-1,0]],
    Matrix[[0,-1,0],[-1,0,0],[0,0,-1]],
    Matrix[[0,0,-1],[-1,0,0],[0,1,0]],

    Matrix[[0,0,-1],[0,1,0],[1,0,0]],
    Matrix[[0,1,0],[0,0,1],[1,0,0]],
    Matrix[[0,0,1],[0,-1,0],[1,0,0]],
    Matrix[[0,-1,0],[0,0,-1],[1,0,0]],

    Matrix[[0,0,-1],[0,-1,0],[-1,0,0]],
    Matrix[[0,-1,0],[0,0,1],[-1,0,0]],
    Matrix[[0,0,1],[0,1,0],[-1,0,0]],
    Matrix[[0,1,0],[0,0,-1],[-1,0,0]]
  ]

  class Scanner
    attr_reader :origin, :beacons

    def initialize(beacons:, origin: nil)
      @beacons = beacons.map{Vector[*_1.split(",").map(&:to_i)]}
      @origin = origin
    end

    def match?(other)
      common_point_map(other).length >= 12
    end

    def reorient!(other)
      rotation, translation = compute_alignment(other)

      @distances = nil
      @origin = translation
      @beacons = @beacons.map{ (rotation * _1) + translation }
    end

    def distances
      return @distances if @distances

      @distances = Hash.new{_1[_2]=[]}
      @beacons.combination(2).each{
        d = distance(_1,_2)
        @distances[_1] << d
        @distances[_2] << d
      }
      @distances.each{_2.sort!}
      @distances
    end

    private

    def compute_alignment(other)
      map = common_point_map(other)

      centroid_a = centroid(map.keys)
      centroid_b = centroid(map.values)

      a, b = map.first

      a1 = (a - centroid_a).round
      b1 = (b - centroid_b).round

      rotation = ROTATION_MATRICES.find{_1*a1 == b1}
      translation = (rotation*a - b) * -1

      [rotation, translation]
    end

    def common_point_map(other)
      @beacons.map{ |beacon|
        match = other.distances.find{
          (_2 & distances[beacon]).length >= 11
        }
        [beacon, match.first] if match
      }.compact.to_h
    end

    def centroid(points)
      points.reduce(:+) / points.length.to_f
    end

    def distance(a, b)
      Math.sqrt((a - b).to_a.sum{_1**2})
    end
  end

  def initialize(input)
    @scanners = input.split("\n\n").map.with_index do |section, idx|
      origin = idx == 0 ? Vector[0,0,0] : nil
      Scanner.new(beacons: section.split("\n")[1..-1], origin: origin)
    end
    @global_beacons = Set.new(@scanners.first.beacons)

    orient_scanners!
  end

  def count
    @global_beacons.length
  end

  def farthest
    @scanners.combination(2).map{ manhattan_distance(*_1.map(&:origin)) }.max
  end

  private

  def orient_scanners!
    until @scanners.all?{_1.origin}
      missing, found = @scanners.partition{_1.origin.nil?}

      match = nil
      scanner = missing.find do |search|
        match = found.find{search.match?(_1)}
      end

      scanner.reorient!(match)

      @global_beacons.merge(scanner.beacons)
    end
  end

  def manhattan_distance(a, b)
    (a - b).to_a.sum{_1.abs}
  end
end
