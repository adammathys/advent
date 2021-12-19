require "json"

class Snailfish
  attr_reader :number

  # Convenience constructor to help make tests easier to read.
  def self.[](number)
    self.new(number)
  end

  def initialize(number)
    @number = number
  end

  def +(other)
    Snailfish["[#{number},#{other.number}]"].reduce!
  end

  def ==(other)
    number == other.number
  end

  def inspect
    number
  end

  def magnitude
    a, b = JSON.parse(number)

    a = a.is_a?(Array) ? Snailfish[a.to_json].magnitude : a
    b = b.is_a?(Array) ? Snailfish[b.to_json].magnitude : b

    3*a + 2*b
  end

  def reduce!
    true while explode! || split!
    self
  end

  def explode!
    return false if max_depth <= 4

    head, pair, tail = find_exploding_pair(JSON.parse(number))

    if (left = head.scan(/\d{1,}/).last)
      idx = head.rindex(left)
      head[idx...(idx+left.length)] = (left.to_i + pair[0]).to_s
    end

    if (right = tail.scan(/\d{1,}/).first)
      idx = tail.index(right)
      tail[idx...(idx+right.length)] = (right.to_i + pair[1]).to_s
    end

    @number = [head,0,tail].join
  end

  def split!
    number.match(/\d{2,}/) do |split|
      head, tail = number.split(split[0], 2)
      m = split[0].to_i / 2.0
      @number = [head, [m.floor, m.ceil].to_json, tail].join
    end
  end

  private

  def max_depth
    array = JSON.parse(number)
    depth = 1

    until array == array.flatten
      depth +=1
      array = array.flatten(1)
    end

    depth
  end

  def find_exploding_pair(pair, depth = 1, head = "", tail = "")
    a, b = pair

    if depth == 4
      return ["#{head}[", a, ",#{b.to_json}]#{tail}"] if a.is_a?(Array)
      return ["#{head}[#{a.to_json},", b, "]#{tail}"] if b.is_a?(Array)
      return false
    end

    find_exploding_pair(a, depth + 1, "#{head}[", ",#{b.to_json}]#{tail}") ||
      find_exploding_pair(b, depth + 1, "#{head}[#{a.to_json},", "]#{tail}")
  end
end
