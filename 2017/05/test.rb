require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_steps
    input = <<-EOS
      0
      3
      0
      1
      -3
    EOS
    assert Solution.(input) == 5
  end

  def test_strange_steps
    input = <<-EOS
      0
      3
      0
      1
      -3
    EOS
    assert Solution.(input, strange: true) == 10
  end
end
