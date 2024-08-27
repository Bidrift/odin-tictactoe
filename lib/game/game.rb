require "colorize"
require_relative "../items/board"
require_relative "../players/human"
require_relative "../players/computer"

# This is the class that has the game itself
class Game
  def initialize
    puts "Initializing game...".colorize(:green)
    @modes = {
      "0" => "Computer vs Computer",
      "1" => "Human vs Computer",
      "2" => "Computer vs Human",
      "3" => "Human vs Human"
    }
    fetch_mode
    create_board
    create_players
    run_game
    end_game
  end

  def restart
    puts "Restarting game...".colorize(:green)
    @board.clear
    run_game
    end_game
  end

  private

  def end_game
    puts "Game over".colorize(:green)
    if @board.full?
      puts "It's a tie"
    else
      puts "The winner is Player #{@winner}".colorize(:green)
    end
  end

  def run_game
    puts "Starting game...".colorize(:green)
    last_player = -1
    until @board.over? || @board.full?
      last_player = (last_player + 1) % 2
      current_player = @players[last_player]
      current_player.play_turn(@board)
    end
    @winner = @board.over? ? last_player : -1
  end

  def create_board
    puts "Creating board...".colorize(:green)
    @board = Board.new
  end

  def create_players
    puts "Creating players...".colorize(:green)
    @players = Array.new(2)
    @players[0] = (@mode == "0") || (@mode == "2") ? Computer.new(0) : Human.new(0)
    @players[1] = (@mode == "2") || (@mode == "3") ? Human.new(1) : Computer.new(1)
  end

  def fetch_mode
    puts "Choosing game mode...".colorize(:green)
    loop do
      puts "Choose a valid game mode number:".colorize(:red)
      @modes.each { |k, v| puts "#{k} - #{v}" }
      @mode = gets.chomp
      break if @modes.key?(@mode)
    end
  end
end
