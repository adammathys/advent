class Duet
  def initialize(input)
    @instructions = input.lines.map(&:split)
    @registers = { 0 => Hash.new(0), 1 => Hash.new(0) }
    @buffers = { 0 => Queue.new, 1 => Queue.new }
    @sends = { 0 => 0, 1 => 0 }
  end

  def total_sends
    @registers[1]["p"] = 1
    zero = 0
    one = 0

    zero = execute(0, 1, 0, zero)
    until @buffers[0].empty? && @buffers[1].empty?
      one = execute(1, 0, 1, one)
      zero = execute(0, 1, 0, zero)
    end

    @sends
  end

  private

  def execute(r_id, write_id, read_id, start)
    r = @registers[r_id]
    write = @buffers[write_id]
    read = @buffers[read_id]

    while start >= 0 && start < @instructions.size
      command, x, y = @instructions[start]
      case command
      when "snd"
        write << parse_value(r, x)
        @sends[r_id] += 1
      when "set"
        r[x] = parse_value(r, y)
      when "add"
        r[x] += parse_value(r, y)
      when "mul"
        r[x] *= parse_value(r, y)
      when "mod"
        r[x] %= parse_value(r, y)
      when "rcv"
        return start if read.empty?
        r[x] = read.pop
      when "jgz"
        if parse_value(r, x) > 0
          start += parse_value(r, y)
          next
        end
      end
      start += 1
    end
    return start
  end

  def parse_value(register, value)
    Integer(value) rescue register[value]
  end
end
