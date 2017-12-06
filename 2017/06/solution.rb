class Solution
  class << self
    def call(input, infinite: false)
      memory = input.split.map(&:to_i)
      configs = []

      while configs.size == configs.uniq.size
        max = memory.max
        index = memory.index(max)

        memory[index] = 0

        max.times do
          index = (index + 1) % memory.size
          memory[index] += 1
        end

        configs << memory.join("-")
      end

      if infinite
        (configs.size - 1) - configs.index(configs.last)
      else
        configs.size
      end
    end
  end
end
