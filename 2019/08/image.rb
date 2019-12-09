class Image
  attr_reader :width, :height

  def initialize(raw, width = 25, height = 6)
    @width = width
    @height = height

    layers = Hash.new { |h,k| h[k] = [] }
    raw.chars.each_with_index do |pixel, idx|
      layer_id = idx / (width * height)
      layers[layer_id] << pixel
    end

    @layers = layers.values
  end

  def checksum
    checksum_layer.count("1") * checksum_layer.count("2")
  end

  def print
    (0...height).map do |y|
      row = (0...width).map do |x|
        case pixel(x, y)
        when "1"
          "█"
        when "0"
          "░"
        end
      end.join("")
      puts row
    end
  end

  private

  def checksum_layer
    @checksum_layer ||= @layers.min_by { |l| l.count("0") }
  end

  def pixel(x, y)
    i = (width * y) + x
    @layers.detect { |l| l[i] != "2" }[i]
  end
end
