require "minitest/autorun"
require_relative "passport"

class PassportTest < Minitest::Test
  def test_valid
    assert Passport.new(
      "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980\n" +
      "hcl:#623a2f"
    ).valid?

    assert Passport.new(
      "eyr:2029 ecl:blu cid:129 byr:1989\n" +
      "iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm"
    ).valid?

    assert Passport.new(
      "hcl:#888785\n" +
      "hgt:164cm byr:2001 iyr:2015 cid:88\n" +
      "pid:545766238 ecl:hzl\n" +
      "eyr:2022"
    ).valid?

    assert Passport.new(
      "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"
    ).valid?
  end

  def test_invalid
    refute Passport.new(
      "eyr:1972 cid:100\n" +
      "hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926"
    ).valid?

    refute Passport.new(
      "iyr:2019\n" +
      "hcl:#602927 eyr:1967 hgt:170cm\n" +
      "ecl:grn pid:012533040 byr:1946"
    ).valid?

    refute Passport.new(
      "hcl:dab227 iyr:2012\n" +
      "ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277"
    ).valid?

    refute Passport.new(
      "hgt:59cm ecl:zzz\n" +
      "eyr:2038 hcl:74454a iyr:2023\n" +
      "pid:3556412378 byr:2007"
    ).valid?
  end
end
