class Solution
  attr_accessor :score, :garbage_count

  def initialize(input)
    @stream = input.chars
    @score = 0
    @garbage_count = 0

    read_stream
  end

  private

  def read_stream
    group = 0
    garbage = false
    bang = false

    @stream.each do |char|
      if bang
        bang = false
        next
      end

      if garbage
        case char
        when "!"
          bang = true
        when ">"
          garbage = false
        else
          @garbage_count += 1
        end
      else
        case char
        when "{"
          group += 1
        when "}"
          @score += group
          group -= 1
        when "<"
          garbage = true
        end
      end
    end
  end
end
