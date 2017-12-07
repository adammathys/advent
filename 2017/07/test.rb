require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  INPUT = <<-EOS
    pbga (66)
    xhth (57)
    ebii (61)
    havc (66)
    ktlj (57)
    fwft (72) -> ktlj, cntj, xhth
    qoyq (66)
    padx (45) -> pbga, havc, qoyq
    tknk (41) -> ugml, padx, fwft
    jptl (61)
    ugml (68) -> gyxo, ebii, jptl
    gyxo (61)
    cntj (57)
  EOS

  def test_bottom_program
    assert Solution.new(INPUT).bottom_program == "tknk"
  end

  def test_balance_weight
    assert Solution.new(INPUT).balance_weight == 60
  end
end
