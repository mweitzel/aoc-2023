def possible
# only 12 red cubes, 13 green cubes, and 14 blue cubes?
  @possible ||= { red: 12, green: 13, blue: 14 }
end

def solve lines
  powers = []
  lines.each do |line|
    game_name, input = line.split(":")
    rounds = input.split(';')
    plays = rounds.flat_map do |round|
      round.split(",").flat_map do |play|
        i, color = play.split(' ').reject(&:empty?)
        {
          color: color,
          count: i.to_i
        }
      end
    end

    requirement_cubes = {}
    plays.each do |play|
      color = play[:color]
      current_required_count = requirement_cubes[color] || 0
      requirement_cubes[color] = [current_required_count, play[:count]].max

      requirement_cubes.map do |_k, v|
        v
      end
    end
      powers << requirement_cubes.values.inject(:*)
  end
  powers.inject(:+)
end

def main
  lines = File.open('./input').readlines
  puts solve(lines)
end

def test
  lines = DATA.readlines
    puts "should be 2286"
    puts 'xxxxxx'
    puts solve(lines)
    puts 'xxxxxx'
end

if __FILE__ == $0
  # test
  main
end


__END__
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
