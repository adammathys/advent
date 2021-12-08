require "pry"

class Display
  class Entry
    SIGNALS = {
      "abcefg" => "0",
      "cf" => "1",
      "acdeg" => "2",
      "acdfg" => "3",
      "bcdf" => "4",
      "abdfg" => "5",
      "abdefg" => "6",
      "acf" => "7",
      "abcdefg" => "8",
      "abcdfg" => "9",
    }

    def initialize(line)
      @signals, @digits = line.split(" | ").map(&:split)
    end

    def output
      @digits.map{convert(_1)}
    end

    def to_i
      output.join.to_i
    end

    private

    def convert(jumbled)
      SIGNALS[jumbled.chars.map{signal_map[_1]}.sort.join]
    end

    def signal_map
      return @signal_map if @signal_map

      stats = @signals.join.chars.tally
      map = {
        ?b => stats.key(6),
        ?e => stats.key(4),
        ?f => stats.key(9)
      }
      map[?c] = @signals.find{_1.length == 2}.chars.find{_1 != map[?f]}
      map[?a] = stats.find{_1[1] == 8 && _1[0] != map[?c]}.first
      map[?d] = (@signals.find{_1.length == 4}.chars - map.values_at(?b, ?c, ?f)).first
      map[?g] = (stats.keys - map.values).first

      @signal_map = map.invert
    end
  end

  def initialize(lines)
    @entries = lines.map{Entry.new(_1)}
  end

  def count(values)
    @entries.flat_map(&:output).count{values.include?(_1)}
  end

  def sum
    @entries.sum(&:to_i)
  end
end
