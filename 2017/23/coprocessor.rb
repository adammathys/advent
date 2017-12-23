class Coprocessor
  attr_accessor :multiplications

  def initialize(input)
    @instructions = input.lines.map(&:split)
    @registers = ("a".."h").map{ |k| [k, 0] }.to_h
    @multiplications = 0
  end

  def run!
    multiplications = 0
    current = 0

    while current >= 0 && current < @instructions.size
      command, x, y = @instructions[current]
      case command
      when "set"
        @registers[x] = parse_value(y)
      when "mul"
        @registers[x] *= parse_value(y)
        @multiplications += 1
      when "sub"
        @registers[x] -= parse_value(y)
      when "jgz"
        if @registers[x] != 0
          current += parse_value(y)
          next
        end
      end
      current += 1
    end
  end

  private

  def parse_value(value)
    Integer(value) rescue @registers[value]
  end
end
