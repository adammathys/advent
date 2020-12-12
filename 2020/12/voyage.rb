require "matrix"

class Voyage
  Ship = Struct.new(:pos, :dir) do
    def move(amount)
      self.pos += (self.dir * amount)
    end

    def drift(vector, waypoint = false)
      if waypoint
        self.dir += vector
      else
        self.pos += vector
      end
    end

    def rotate(amount)
      case amount
      when 90
        self.dir = Vector[self.dir[1] * -1, self.dir[0]]
      when 180
        self.dir *= -1
      when 270
        self.dir = Vector[self.dir[1], self.dir[0] * -1]
      end
    end

    def distance(origin)
      (self.pos - origin).to_a.map(&:abs).sum
    end
  end

  attr_reader :ship

  def initialize(actions)
    @actions = actions
  end

  def simulate(waypoint = false)
    @ship = Ship.new(
      Vector[0,0],
      waypoint ? Vector[10,1] : Vector[1,0]
    )
    @actions.each do |action|
      amount = action[1..-1].to_i
      case action[0]
      when "N"
        vector = Vector[0,1] * amount
        ship.drift(vector, waypoint)
      when "E"
        vector = Vector[1,0] * amount
        ship.drift(vector, waypoint)
      when "S"
        vector = Vector[0,-1] * amount
        ship.drift(vector, waypoint)
      when "W"
        vector = Vector[-1,0] * amount
        ship.drift(vector, waypoint)
      when "L"
        ship.rotate(amount)
      when "R"
        ship.rotate(360 - amount)
      when "F"
        ship.move(amount)
      end
    end
  end
end
