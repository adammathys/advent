class Codes
  Point = Struct.new(:position, :velocity) do
    def at(time)
      [
        position[0] + time * velocity[0],
        position[1] + time * velocity[1]
      ]
    end
  end

  def initialize(input)
    @points = input.map do |point|
      data = /position=<([- ]\d+), ([- ]\d+)> velocity=<([- ]\d+), ([- ]\d+)>/.
        match(point).to_a[1..-1].map(&:to_i)
      Point.new(data.first(2), data.last(2))
    end
  end

  def run
    t = 0
    loop do
      draw(t)
      t += 1
    end
  end

  private

  def draw(t)
    points = @points.map { |p| p.at(t) }
    min_x, max_x = points.map(&:first).minmax
    min_y, max_y = points.map(&:last).minmax
    area = (max_x - min_x) * (max_y - min_y)

    # Random guess at how big an area we need for our message.
    return if area > 2000

    puts "----------------------------------"
    puts "TIME: #{t}"
    min_y.upto(max_y) do |y|
      min_x.upto(max_x) do |x|
        print points.include?([x, y]) ? "#" : "."
      end
      puts
    end
  end
end
