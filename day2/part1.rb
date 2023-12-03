def possible
# only 12 red cubes, 13 green cubes, and 14 blue cubes?
  @possible ||= { red: 12, green: 13, blue: 14 }
end

def solve lines
  valid = []
  lines.each do |line|
    game_name, input = line.split(":")
    rounds = input.split(';')
    plays = rounds.flat_map { |round| round.split(",").flat_map { |play| i, color = play.split(' ').reject(&:empty?); { color: color, count: i.to_i } } }
    invalid_play = plays.find do |play|
      valid_count = possible[play[:color].to_sym]
      play[:count] > valid_count
    end
   # puts invalid_play
    if invalid_play.nil?
      valid << game_name.split(' ').last.to_i
    else
      next
    end
  end
  valid.inject(:+)
end

def main
a =  solve File.open('./input').readlines
#   puts 'main'
   puts a
  #test
end

def test
  lines = DATA.readlines
  solve lines
end

if __FILE__ == $0
    main()
end


__END__
Game 1: 1 green, 1 blue, 1 red; 1 green, 8 red, 7 blue; 6 blue, 10 red; 4 red, 9 blue, 2 green; 1 green, 3 blue; 4 red, 1 green, 10 blue
Game 2: 9 red, 7 green, 3 blue; 15 green, 2 blue, 5 red; 10 red, 3 blue, 13 green
Game 3: 3 red, 1 blue, 4 green; 6 red, 3 green, 2 blue; 6 red, 16 blue, 1 green
Game 4: 2 blue, 2 green, 19 red; 3 blue, 11 red, 16 green; 18 blue, 13 green, 20 red; 18 red, 12 blue, 16 green; 8 green, 16 blue, 16 red
Game 5: 8 green, 1 red, 12 blue; 10 green, 6 red, 13 blue; 1 red, 3 blue, 6 green; 14 blue, 2 red, 7 green
