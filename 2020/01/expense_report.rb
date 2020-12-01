class ExpenseReport
  def initialize(entries)
    @entries = entries.map(&:to_i)
  end

  def twenty_twenty(combo_length = 2)
    @entries.combination(combo_length).find { |combo|
      combo.sum == 2020
    }.reduce(&:*)
  end
end
