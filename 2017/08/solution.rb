class Solution
  attr_accessor :max

  def initialize(input)
    @commands = input.lines.map { |l| l.split("if") }
    @registers = Hash.new { |h, k| h[k] = 0 }
    @max = 0

    execute_commands
  end

  def largest_value
    @registers.values.max
  end

  private

  def execute_commands
    @commands.each do |command, condition|
      if check_condition(condition)
        value = execute_command(command)
        @max = value if value > @max
      end
    end
  end

  def check_condition(condition)
    register, operator, value = condition.split
    @registers[register].send(operator, value.to_i)
  end

  def execute_command(command)
    register, operator, value = command.split
    case operator
    when "inc"
      @registers[register] += value.to_i
    when "dec"
      @registers[register] -= value.to_i
    end
  end
end
