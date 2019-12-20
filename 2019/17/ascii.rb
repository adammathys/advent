require_relative "intcode"

class Ascii
  attr_reader :graph

  def initialize(state)
    @graph = Graph.new
    @state = state
  end

  def display
    output = Intcode.new(@state).run
    output.each { |t| graph.add_tile(t) }
    graph.print
  end

  def dust_collected(instructions)
    state = @state.dup
    state[0] = 2
    output = Intcode.new(state, instructions).run
    output.last
  end

  class Graph
    attr_reader :height, :width

    def initialize
      @height = 0
      @width = nil
      @tiles = []
    end

    def add_tile(val)
      case val
      when 10
        @height += 1
        @width ||= @tiles.length
      else
        @tiles.append(val.chr)
      end
    end

    def alignment_sum
      (0...height).sum do |y|
        (0...width).sum do |x|
          if intersection?(x, y)
            x * y
          else
            0
          end
        end
      end
    end

    def print
      (0...height).each do |y|
        puts (0...width).map { |x| pixel(x, y) }.join("")
      end
    end

    private

    def intersection?(x, y)
      return false if pixel(x, y) != "#"

      [
        pixel(x - 1, y),
        pixel(x + 1, y),
        pixel(x, y - 1),
        pixel(x, y + 1)
      ].all? { |p| p == "#" }
    end

    def pixel(x, y)
      @tiles[(width * y) + x]
    end
  end
end
