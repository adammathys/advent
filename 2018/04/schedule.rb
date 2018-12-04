require "time"

class Schedule
  def initialize(input)
    @input = input.sort
    parse_sleep_schedule
  end

  def most_asleep
    @guards_sleep.max_by { |_, sleep| sleep.sum }.first
  end

  def most_frequent
    @guards_sleep.map do |guard, sleep|
      minute = best_minute(guard)
      [guard, minute, sleep[minute]]
    end.max_by { |x| x[2] }
  end

  def best_minute(guard)
    @guards_sleep[guard].index(@guards_sleep[guard].max)
  end

  private

  def parse_sleep_schedule
    @guards_sleep = Hash.new { |h, k| h[k] = Array.new(60) { 0 } }

    current_guard = nil
    sleep_start = nil

    @input.each do |entry|
      _, time, note = /\A\[(.*?)\] (.*?)\z/.match(entry).to_a
      time = Time.parse(time)

      case note
      when /Guard #(\d+) begins shift/
        current_guard = $1.to_i
      when /falls asleep/
        sleep_start = time.min
      when /wakes up/
        sleep_end = time.min
        sleep_start.upto(sleep_end - 1) do |min|
          @guards_sleep[current_guard][min] += 1
        end
        sleep_start = nil
      end
    end
  end
end
