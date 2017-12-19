class Duet
  def initialize(input)
    @instructions = input.lines.map(&:split)
    @registers = Hash.new(0)
    @played = Queue.new
  end

  def first_recovered
    execute
  end

  private

  def execute
    @registers.clear
    @played.clear
    current = 0

    while current >= 0 && current < @instructions.size
      command, x, y = @instructions[current]
      case command
      when "snd"
        @played << {x => @registers[x]}
      when "set"
        @registers[x] = parse_value(y)
      when "add"
        @registers[x] += parse_value(y)
      when "mul"
        @registers[x] *= parse_value(y)
      when "mod"
        @registers[x] %= parse_value(y)
      when "rcv"
        if @registers[x] != 0
          key, value = @played.pop.first
          @registers[key] = value
          return value
        end
      when "jgz"
        if @registers[x] > 0
          current += parse_value(y)
          next
        end
      end
      current += 1
    end
  end

  def parse_value(value)
    Integer(value) rescue @registers[value]
  end
end
