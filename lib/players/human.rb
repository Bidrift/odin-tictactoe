require_relative "player"
require_relative "../items/board"

# A real human class of a player
class Human < Player
  protected

  def choose_move(board)
    board.show_board
    fetch_choice(board)
  end

  private

  def fetch_choice(board)
    loop do
      puts "Choose your move according to the numbers on board (1-9)".colorize(:red)
      choice = gets
      return choice.to_i if choice.to_i.to_s.match?(/^[1-9]$/) && board.valid?(choice.to_i)
    end
  end
end
