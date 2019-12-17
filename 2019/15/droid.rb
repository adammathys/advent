require "matrix"
require "pry"
require_relative "intcode"

class Droid
  DIRECTIONS = {
    1 => Vector[0,1],
    2 => Vector[0,-1],
    3 => Vector[-1,0],
    4 => Vector[1,0]
  }

  def initialize
    @tiles = []
    origin = Tile.new(@tiles, Vector[0,0], [])
    origin.discover_tiles
  end

  def optimal_path
    @tiles.find(&:oxygen).moves.length
  end

  def fill_time
    step = 0

    until @tiles.all?(&:oxygen)
      @tiles.select(&:oxygen).each(&:fill_neighbours)
      step += 1
    end

    step
  end

  class Tile
    attr_accessor :oxygen
    attr_reader :position, :moves

    def initialize(tiles, position, moves, skip = nil, oxygen = false)
      @tiles = tiles
      @position = position
      @moves = moves
      @skip = skip
      @oxygen = oxygen
    end

    def discover_tiles
      return if @oxygen

      DIRECTIONS.map do |code, direction|
        next if @skip == code

        inputs = moves + [code]
        position = @position + direction
        skip = case code
               when 1 then 2
               when 2 then 1
               when 3 then 4
               when 4 then 3
               end
        intcode = Intcode.new(INITIAL_MEMORY, inputs)
        output = intcode.run

        case output.last
        when 0
          # Hit a wall, no need to go further.
          nil
        when 1
          tile = Tile.new(@tiles, position, inputs, skip)
          @tiles << tile
          tile.discover_tiles
        when 2
          @tiles << Tile.new(@tiles, position, inputs, skip, true)
        end
      end
    end

    def fill_neighbours
      DIRECTIONS.map do |_, direction|
        position = @position + direction
        tile = @tiles.find { |x| x.position == position }
        next unless tile
        tile.oxygen = true
      end
    end
  end
end
