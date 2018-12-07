class Elvish
  REGEX = /Step ([A-Z]) must be finished before step ([A-Z]) can begin./

  def initialize(input)
    @input = input
    generate_graph
  end

  def sort
    result = []
    graph = @graph.dup

    while result.length < @nodes.length
      active = graph.select { |_,v| v[:parents].empty? }
      node = active.keys.sort.first

      result << node

      graph.delete(node)
      graph.values.each { |v| v[:parents].delete(node) }
    end

    result.join
  end

  def time(num_workers: 2, base_duration: 0)
    workers = Array.new(num_workers) { Hash.new }
    time = 0
    result = []

    graph = @graph.dup

    while result.length < @nodes.length
      workers.each do |worker|
        if worker[:current] && worker[:ready] == time
          node = worker[:current]
          result << node

          graph.delete(node)
          graph.values.each { |v| v[:parents].delete(node) }

          worker[:current] = nil
          worker[:ready] = nil
        end
      end

      active = graph.select { |_,v| v[:parents].empty? }.keys.sort
      (active - workers.map { |w| w[:current] }).each do |node|
        free = workers.find { |w| w[:current].nil? }
        if free
          free[:current] = node
          free[:ready] = time + base_duration + (node.ord - 64)
        end
      end

      time += 1
    end

    time - 1
  end

  private

  def generate_graph
    @graph = Hash.new { |h,k| h[k] = { parents: [] } }
    @nodes = Set.new

    @input.each do |step|
      a, b = REGEX.match(step).to_a[1..-1]
      @nodes << a
      @nodes << b
      @graph[b][:parents] << a
    end

    (@nodes - @graph.keys).each do |node|
      @graph[node][:parents] = []
    end
  end
end
