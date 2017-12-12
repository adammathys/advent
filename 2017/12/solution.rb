require "set"

class Solution
  def initialize(input)
    @groups = parse_input(input)
  end

  def group_size(base)
    nodes = group_nodes(base)
    nodes.size
  end

  def group_count
    count = 0
    nodes = Set.new

    @groups.keys.each do |base|
      next if nodes.include?(base)
      nodes = group_nodes(base, nodes: nodes)
      count += 1
    end

    count
  end

  private

  def group_nodes(base, nodes: Set.new)
    nodes << base
    subs = @groups[base]

    subs.select { |sub| !nodes.include?(sub) }.each do |sub|
      nodes = group_nodes(sub, nodes: nodes)
    end
    nodes
  end

  def parse_input(input)
    result = {}
    input.lines.each do |line|
      base, children = line.split("<->")
      result[base.to_i] = children.split(",").map(&:to_i)
    end
    result
  end
end
