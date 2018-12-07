require_relative "graph"
require_relative "elf"

class Elvish
  REGEX = /Step ([A-Z]) must be finished before step ([A-Z]) can begin./

  def initialize(input)
    @input = input
  end

  def sort
    result = []
    graph = generate_graph

    while graph.size >= 1
      node = graph.parentless.sort.first
      result << node.name
      graph.pop(node)
    end

    result.join
  end

  def time(num_workers: 2, base_duration: 0)
    workers = Array.new(num_workers) { Elf.new }
    graph = generate_graph
    time = -1

    while graph.size >= 1
      workers.each do |worker|
        if worker.working? && worker.ready?(time)
          graph.pop(worker.current_node)
          worker.reset
        end
      end

      active = graph.parentless
      in_progress = workers.map { |worker| worker.current_node }.compact

      (active - in_progress).each do |node|
        if (free = workers.find(&:free?))
          free.current_node = node
          free.ready_at = time + base_duration + (node.name.ord - 64)
        end
      end

      time += 1
    end

    time
  end

  private

  def generate_graph
    graph = Graph.new
    @input.each do |step|
      a, b = REGEX.match(step).to_a[1..-1]
      graph.add(b, a)
    end
    graph
  end
end
