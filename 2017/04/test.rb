require "minitest/autorun"
require_relative "solution"

class SolutionTest < Minitest::Test
  def test_passcodes
    input = <<-EOS
      aa bb cc dd ee
      aa bb cc dd aa
      aa bb cc dd aaa
    EOS
    assert Solution.(input) == 2
  end

  def test_anagram_passcodes
    input = <<-EOS
      abcde fghij
      abcde xyz ecdab
      a ab abc abd abf abj
      iiii oiii ooii oooi oooo
      oiii ioii iioi iiio
    EOS
    assert Solution.(input, anagrams: true) == 3
  end
end
