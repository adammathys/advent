require_relative "knot_hash"

class Disk
  def initialize(key)
    @base_key = key
    @hash = KnotHash.new(256)
    @data = initialize_data
  end

  def used
    @data.sum { |row| row.count("U") }
  end

  def regions
    writable_disk = @data.map { |d| d.dup }
    count = 0

    loop do
      unmarked = writable_disk.sum { |row| row.count("U") }
      break if unmarked == 0
      count += 1
      x, y = find_region(writable_disk)
      fill_region(writable_disk, [x, y], count)
    end

    count
  end

  private

  def find_region(disk)
    (0..127).each do |y|
      (0..127).each do |x|
        return x, y if disk[y][x] == "U"
      end
    end
  end

  def fill_region(disk, origin, value)
    x, y = origin
    return if (x < 0 || y < 0 || x >= 128 || y >= 128)
    return if disk[y][x] != "U"

    disk[y][x] = value

    fill_region(disk, [x + 1, y], value)
    fill_region(disk, [x - 1, y], value)
    fill_region(disk, [x, y + 1], value)
    fill_region(disk, [x, y - 1], value)
  end

  def count_used(disk)
  end

  def initialize_data
    (0..127).map do |i|
      key = @hash.hash("#{@base_key}-#{i}")
      binary = key.chars.map { |c| "%04b" % c.hex }.join.chars
      binary.map { |b| b == "1" ? "U" : "." }
    end
  end
end
