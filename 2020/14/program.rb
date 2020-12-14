class Program
  def initialize(instructions)
    @instructions = parse(instructions)
  end

  def run!(version: 1)
    @memory = Hash.new(0)
    @instructions.each do |action, value|
      if action == :mask
        @mask = {
          mand: value.tr("01X", "001").to_i(2),
          mor: value.tr("01X", "010").to_i(2)
        }
        if version == 2
          @mask[:mfloat] = generate_masks([value.tr("01", "00")])
        end
      else
        if version == 2
          decode(action).each { |address| @memory[address] = value }
        else
          @memory[action] = (value & @mask[:mand]) | @mask[:mor]
        end
      end
    end
  end

  def memory
    @memory.values
  end

  private

  def decode(address)
    @mask[:mfloat].map do |mfloat|
      (address | @mask[:mor]) ^ mfloat
    end
  end

  def generate_masks(masks)
    masks.flat_map do |mask|
      zero = mask.sub("X", "0")
      one = mask.sub("X", "1")
      if zero.include?("X")
        generate_masks([zero, one])
      else
        [zero.to_i(2), one.to_i(2)]
      end
    end
  end

  def parse(instructions)
    instructions.map do |instruction|
      action, value = instruction.split(' = ')
      if action == "mask"
        [:mask, value.strip]
      else
        action.match(/mem\[(\d+)\]/)
        [$1.to_i, value.strip.to_i]
      end
    end
  end
end
