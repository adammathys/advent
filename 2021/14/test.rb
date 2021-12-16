require "minitest/autorun"
require_relative "polymer"

class PolymerTest < Minitest::Test
  def setup
    rules = [
      "CH -> B",
      "HH -> N",
      "CB -> H",
      "NH -> C",
      "HB -> C",
      "HC -> B",
      "HN -> C",
      "NN -> C",
      "BH -> H",
      "NC -> B",
      "NB -> B",
      "BN -> B",
      "BB -> N",
      "BC -> B",
      "CC -> N",
      "CN -> C"
    ]
    @polymer = Polymer.new("NNCB", rules)
    10.times { @polymer.insert }
  end

  def test_most_common
    assert_equal 1749, @polymer.most_common
  end

  def test_least_common
    assert_equal 161, @polymer.least_common
  end
end
