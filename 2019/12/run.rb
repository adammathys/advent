require_relative "moon"

moons = [
  Moon.new(-13, 14, -7),
  Moon.new(-18, 9, 0),
  Moon.new(0, -3, -3),
  Moon.new(-15, 3, -13)
]
cycles = Array.new(3)
step = 0

until cycles.all?
  moons.each do |moon|
    moon.apply_gravity(moons - [moon])
  end
  moons.each(&:move)

  step += 1

  cycles.each_with_index do |cycle, i|
    if moons.all? { |x| x.returned?(i) }
      cycles[i] ||= step
    end
  end
end

puts cycles.reduce(:lcm)
