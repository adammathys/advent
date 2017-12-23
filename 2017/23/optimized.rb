require "prime"

b = 108100
c = 125100
h = 0
b.step(c + 1, 17) do |x|
  h += 1 unless Prime.prime?(x)
end
puts h
