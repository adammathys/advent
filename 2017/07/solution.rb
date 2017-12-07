class Solution
  INPUT_REGEX = /^([a-z]+)\s+\(([0-9]+)\)(?:\s+->\s+([\w\s,]+))?$/

  def initialize(input)
    @tower = []
    input.lines.map(&:strip).each do |line|
      name, weight, children = line.match(INPUT_REGEX).captures

      program = find_or_create_program(name)
      program.children = children ? children.split(", ") : []
      program.weight = weight.to_i
      update_level(program, program.level)
    end
  end

  def bottom_program
    @tower.find { |k| k.level == 0 }.name
  end

  def balance_weight
    base = @tower.find { |k| k.level == 0 }
    find_mismatched_weight(find_programs(base.children))
  end

  private

  Program = Struct.new(:name, :weight, :level, :children)

  def find_or_create_program(name)
    program = @tower.find { |k| k.name == name }
    unless program
      program = Program.new(name)
      program.children = []
      program.level = 0
      @tower << program
    end
    program
  end

  def find_programs(names)
    names.map { |name| @tower.find { |k| k.name == name } }
  end

  def update_level(program, new_level)
    program.level = new_level
    program.children.each do |child|
      child = find_or_create_program(child)
      update_level(child, new_level + 1)
    end
  end

  def find_weight(program)
    children_weight = find_programs(program.children).map do |child|
      find_weight(child)
    end.sum
    program.weight + children_weight
  end

  def find_mismatched_weight(programs)
    weights = programs.map { |program| [program, find_weight(program)] }.to_h

    uniq_value = weights.values.find { |v| weights.values.count(v) == 1 }
    mismatch = weights.key(uniq_value)

    if mismatch
      if mismatch.children
        mismatch_child = find_mismatched_weight(
          find_programs(mismatch.children)
        )
        return mismatch_child if mismatch_child
      end

      difference = weights.values.uniq.reduce(&:-).abs
      mismatch.weight - difference
    else
      nil
    end
  end
end
