class Subsystem
  class Chunk
    PAIRS = {
      ")" => "(",
      "]" => "[",
      "}" => "{",
      ">" => "<"
    }

    attr_reader :illegal_char

    def initialize(line)
      @stack = []
      @illegal_char = nil

      parse_line(line)
    end

    def corrupted?
      !@illegal_char.nil?
    end

    def missing_chars
      return if corrupted?
      @stack.reverse.map{PAIRS.key(_1)}
    end

    private

    def parse_line(line)
      line.chars.each do
        if PAIRS.key?(_1)
          open = @stack.pop
          return @illegal_char = _1 if open != PAIRS[_1]
        else
          @stack << _1
        end
      end
    end
  end

  def initialize(lines)
    @chunks = lines.map{Chunk.new(_1)}
  end

  def corrupted_score
    points = {
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137
    }
    @chunks.select(&:corrupted?).sum{ points[_1.illegal_char] }
  end

  def incomplete_score
    points = %w|) ] } >|
    scores = @chunks.reject(&:corrupted?).map{
      _1.missing_chars.reduce(0) { |total, c|
        (total * 5) + (points.index(c) + 1)
      }
    }.sort
    scores[scores.length / 2]
  end
end
