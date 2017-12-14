class KnotHash
  def initialize(hash_size)
    @hash_size = hash_size
  end

  def hash(input)
    list = (0...@hash_size).to_a
    current = 0
    skip = 0

    salt = [17, 31, 73, 47, 23]
    lengths = input.chars.map(&:ord) + salt

    64.times do
      lengths.each do |length|
        next if length > list.size

        reversed = [*list, *list].slice(current, length).reverse
        reversed.each do |r|
          list[current] = r
          current = (current + 1) % list.size
        end

        current = (current + skip) % list.size
        skip += 1
      end
    end

    list.each_slice(16).map do |slice|
      "%02x" % slice.reduce(&:^)
    end.join
  end
end
