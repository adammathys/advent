class Solution
  def initialize(hash_size)
    @hash_size = hash_size
  end

  def check(lengths)
    list = generate_list!
    reset_indices!

    list = hash_once(list, lengths)
    list[0] * list[1]
  end

  def knot_hash(input)
    list = generate_list!
    reset_indices!

    salt = [17, 31, 73, 47, 23]
    lengths = input.chars.map(&:ord) + salt

    64.times { list = hash_once(list, lengths) }

    list.each_slice(16).map do |slice|
      "%02x" % slice.reduce(&:^)
    end.join
  end

  private

  def hash_once(list, lengths)
    lengths.each do |length|
      next if length > list.size

      reversed = [*list, *list].slice(@current, length).reverse
      reversed.each do |r|
        list[@current] = r
        @current = (@current + 1) % list.size
      end

      @current = (@current + @skip) % list.size
      @skip += 1
    end

    list
  end

  def generate_list!
    (0...@hash_size).to_a
  end

  def reset_indices!
    @current = 0
    @skip = 0
  end
end
