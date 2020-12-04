require "pry"

class Passport
  REQUIRED_KEYS = %w(byr iyr eyr hgt hcl ecl pid)

  def initialize(raw)
    @details = raw.split(/\s/).map { |info| info.split(":") }.to_h
  end

  def valid?
    return false unless (REQUIRED_KEYS - @details.keys).empty?
    @details.all? do |key, value|
      case key
      when 'byr'
        /^\d{4}$/.match?(value) && (1920..2002).cover?(value.to_i)
      when 'iyr'
        /^\d{4}$/.match?(value) && (2010..2020).cover?(value.to_i)
      when 'eyr'
        /^\d{4}$/.match?(value) && (2020..2030).cover?(value.to_i)
      when 'hgt'
        /^(\d*)(cm|in)$/.match(value) &&
          $2 == "cm" ? (150..193).cover?($1.to_i) : (59..76).cover?($1.to_i)
      when 'hcl'
        /^#[0-9a-f]{6}$/.match?(value)
      when 'ecl'
        %w(amb blu brn gry grn hzl oth).include?(value)
      when 'pid'
        /^\d{9}$/.match?(value)
      when 'cid'
        true
      end
    end
  end
end
