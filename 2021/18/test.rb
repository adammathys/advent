require "minitest/autorun"
require_relative "snailfish"

class SnailfishTest < Minitest::Test
  def test_addition
    assert_equal Snailfish["[[1,2],[[3,4],5]]"], [
      Snailfish["[1,2]"],
      Snailfish["[[3,4],5]"]
    ].reduce(:+)

    assert_equal Snailfish["[[[[1,1],[2,2]],[3,3]],[4,4]]"], [
      Snailfish["[1,1]"],
      Snailfish["[2,2]"],
      Snailfish["[3,3]"],
      Snailfish["[4,4]"]
    ].reduce(:+)

    assert_equal Snailfish["[[[[3,0],[5,3]],[4,4]],[5,5]]"], [
      Snailfish["[1,1]"],
      Snailfish["[2,2]"],
      Snailfish["[3,3]"],
      Snailfish["[4,4]"],
      Snailfish["[5,5]"]
    ].reduce(:+)

    assert_equal Snailfish["[[[[5,0],[7,4]],[5,5]],[6,6]]"], [
      Snailfish["[1,1]"],
      Snailfish["[2,2]"],
      Snailfish["[3,3]"],
      Snailfish["[4,4]"],
      Snailfish["[5,5]"],
      Snailfish["[6,6]"]
    ].reduce(:+)
  end

  def test_complex_addition
    assert_equal Snailfish["[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]"],
      Snailfish["[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]"] +
      Snailfish["[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]"]

    assert_equal Snailfish["[[[[6,7],[6,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]]"],
      Snailfish["[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]"] +
      Snailfish["[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]"]

    assert_equal Snailfish["[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]]"],
      Snailfish["[[[[6,7],[6,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]]"] +
      Snailfish["[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]"]

    assert_equal Snailfish["[[[[7,7],[7,8]],[[9,5],[8,7]]],[[[6,8],[0,8]],[[9,9],[9,0]]]]"],
      Snailfish["[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]]"] +
      Snailfish["[7,[5,[[3,8],[1,4]]]]"]

    assert_equal Snailfish["[[[[6,6],[6,6]],[[6,0],[6,7]]],[[[7,7],[8,9]],[8,[8,1]]]]"],
      Snailfish["[[[[7,7],[7,8]],[[9,5],[8,7]]],[[[6,8],[0,8]],[[9,9],[9,0]]]]"] +
      Snailfish["[[2,[2,2]],[8,[8,1]]]"]

    assert_equal Snailfish["[[[[6,6],[7,7]],[[0,7],[7,7]]],[[[5,5],[5,6]],9]]"],
      Snailfish["[[[[6,6],[6,6]],[[6,0],[6,7]]],[[[7,7],[8,9]],[8,[8,1]]]]"] +
      Snailfish["[2,9]"]

    assert_equal Snailfish["[[[[7,8],[6,7]],[[6,8],[0,8]]],[[[7,7],[5,0]],[[5,5],[5,6]]]]"],
      Snailfish["[[[[6,6],[7,7]],[[0,7],[7,7]]],[[[5,5],[5,6]],9]]"] +
      Snailfish["[1,[[[9,3],9],[[9,0],[0,7]]]]"]

    assert_equal Snailfish["[[[[7,7],[7,7]],[[8,7],[8,7]]],[[[7,0],[7,7]],9]]"],
      Snailfish["[[[[7,8],[6,7]],[[6,8],[0,8]]],[[[7,7],[5,0]],[[5,5],[5,6]]]]"] +
      Snailfish["[[[5,[7,4]],7],1]"]

    assert_equal Snailfish["[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"],
      Snailfish["[[[[7,7],[7,7]],[[8,7],[8,7]]],[[[7,0],[7,7]],9]]"] +
      Snailfish["[[[[4,2],2],6],[8,7]]"]
  end

  def test_magnitude
    assert_equal 143, Snailfish["[[1,2],[[3,4],5]]"].magnitude
    assert_equal 1384, Snailfish["[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"].magnitude
    assert_equal 445, Snailfish["[[[[1,1],[2,2]],[3,3]],[4,4]]"].magnitude
    assert_equal 791, Snailfish["[[[[3,0],[5,3]],[4,4]],[5,5]]"].magnitude
    assert_equal 1137, Snailfish["[[[[5,0],[7,4]],[5,5]],[6,6]]"].magnitude
    assert_equal 3488, Snailfish["[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"].magnitude
  end

  def test_split
    assert_equal "[[5,5],0]", Snailfish["[10,0]"].split!
    assert_equal "[0,[5,6]]", Snailfish["[0,11]"].split!

    assert_equal "[0,[[6,6],0]]", Snailfish["[0,[12,0]]"].split!
    assert_equal "[0,[[6,7],[0,14]]]", Snailfish["[0,[13,[0,14]]]"].split!

    assert_equal "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]",
      Snailfish["[[[[0,7],4],[15,[0,13]]],[1,1]]"].split!

    refute Snailfish["[0,[1,[3,[[4,5],6]]]]"].split!
  end

  def test_explode
    assert_equal "[[[[0,9],2],3],4]", Snailfish["[[[[[9,8],1],2],3],4]"].explode!
    assert_equal "[7,[6,[5,[7,0]]]]", Snailfish["[7,[6,[5,[4,[3,2]]]]]"].explode!
    assert_equal "[[6,[5,[7,0]]],3]", Snailfish["[[6,[5,[4,[3,2]]]],1]"].explode!

    assert_equal "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]",
      Snailfish["[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]"].explode!
    assert_equal "[[3,[2,[8,0]]],[9,[5,[7,0]]]]",

      Snailfish["[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]"].explode!

    assert_equal "[[[[6,7],[0,7]],[[13,0],[7,21]]],[[2,[11,10]],[[0,8],[8,0]]]]",
      Snailfish["[[[[6,7],[0,7]],[[7,[6,7]],[0,21]]],[[2,[11,10]],[[0,8],[8,0]]]]"].explode!

    refute Snailfish["[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"].explode!
  end

  def test_reduce
    assert_equal Snailfish["[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"],
      Snailfish["[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]"].reduce!
  end
end
