class Solution
  class << self
    def call(input, anagrams: false)
      input.lines.select do |line|
        words = line.split.map do |word|
          anagrams ? word.chars.sort.join : word
        end
        words.length == words.uniq.length
      end.length
    end
  end
end
