require_relative "garden"

initial = "##.......#.######.##..#...#.#.#..#...#..####..#.##...#....#...##..#..#.##.##.###.##.#.......###....#"
rules = {
  ".####" => ".",
  "....#" => ".",
  "###.." => ".",
  "..#.#" => ".",
  "#####" => "#",
  "####." => ".",
  "#.##." => "#",
  "#.#.#" => ".",
  "##.#." => "#",
  ".###." => ".",
  "#..#." => "#",
  "###.#" => ".",
  "#.###" => ".",
  "##..." => "#",
  ".#.##" => ".",
  "..#.." => ".",
  "#...#" => "#",
  "....." => ".",
  ".##.." => ".",
  "...#." => ".",
  "#.#.." => ".",
  ".#..#" => "#",
  ".#.#." => ".",
  ".#..." => "#",
  "..##." => ".",
  "#..##" => ".",
  "##.##" => "#",
  "...##" => "#",
  "..###" => "#",
  "#...." => ".",
  ".##.#" => "#",
  "##..#" => "#"
}

garden =  Garden.new(initial: initial, rules: rules)
puts "Yield: #{garden.yield(generations: 20)}"

puts "Mega Yield: #{garden.yield(generations: 50_000_000_000)}"
