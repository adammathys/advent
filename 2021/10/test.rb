require "minitest/autorun"
require_relative "subsystem"

class SubsystemTest < Minitest::Test
  def test_corrupted
    assert Subsystem::Chunk.new("(]").corrupted?
    assert Subsystem::Chunk.new("{()()()>").corrupted?
    assert Subsystem::Chunk.new("(((()))}").corrupted?
    assert Subsystem::Chunk.new("<([]){()}[{}])").corrupted?
  end

  def test_corrupted_score
    input = [
      "[({(<(())[]>[[{[]{<()<>>",
      "[(()[<>])]({[<{<<[]>>(",
      "{([(<{}[<>[]}>{[]{[(<()>",
      "(((({<>}<{<{<>}{[]{[]{}",
      "[[<[([]))<([[{}[[()]]]",
      "[{[{({}]{}}([{[{{{}}([]",
      "{<[[]]>}<{[{[{[]{()[[[]",
      "[<(<(<(<{}))><([]([]()",
      "<{([([[(<>()){}]>(<<{{",
      "<{([{{}}[<[[[<>{}]]]>[]]"
    ]
    assert_equal 26397, Subsystem.new(input).corrupted_score
  end

  def test_missing_chars
    assert_equal "}}]])})]".chars,  Subsystem::Chunk.new("[({(<(())[]>[[{[]{<()<>>").missing_chars
    assert_equal ")}>]})".chars,    Subsystem::Chunk.new("[(()[<>])]({[<{<<[]>>(").missing_chars
    assert_equal "}}>}>))))".chars, Subsystem::Chunk.new("(((({<>}<{<{<>}{[]{[]{}").missing_chars
    assert_equal "]]}}]}]}>".chars, Subsystem::Chunk.new("{<[[]]>}<{[{[{[]{()[[[]").missing_chars
    assert_equal "])}>".chars,      Subsystem::Chunk.new("<{([{{}}[<[[[<>{}]]]>[]]").missing_chars
  end

  def test_incomplete_score
    input = [
      "[({(<(())[]>[[{[]{<()<>>",
      "[(()[<>])]({[<{<<[]>>(",
      "{([(<{}[<>[]}>{[]{[(<()>",
      "(((({<>}<{<{<>}{[]{[]{}",
      "[[<[([]))<([[{}[[()]]]",
      "[{[{({}]{}}([{[{{{}}([]",
      "{<[[]]>}<{[{[{[]{()[[[]",
      "[<(<(<(<{}))><([]([]()",
      "<{([([[(<>()){}]>(<<{{",
      "<{([{{}}[<[[[<>{}]]]>[]]"
    ]
    assert_equal 288957, Subsystem.new(input).incomplete_score
  end
end
