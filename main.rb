require_relative "lib/game/game"

options = {
  "1" => "Restart the game",
  "2" => "Start a new game",
  "3" => "Quit"
}

loop do
  game = Game.new
  loop do
    choice = 0
    loop do
      puts "Select an option (1-3)".colorize(:red)
      options.each { |k, v| puts "#{k} - #{v}" }
      choice = gets.chomp
      break if options.key?(choice)
    end
    case choice
    when "1" then game.restart
    when "2" then break
    when "3" then exit
    end
  end
end
