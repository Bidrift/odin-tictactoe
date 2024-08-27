require_relative "player"
require_relative "../items/board"

# An AI computer as a player
class Computer < Player
  protected

  def choose_move(board)
    find_win(board) || find_loss(board) || random_move(board)
  end

  private

  def find_win(board)
    board.valid_moves.select { |v| board.winning_move?(v, @player) }[0]
  end

  def find_loss(board)
    board.valid_moves.select { |v| board.losing_move?(v, @player) }[0]
  end

  def random_move(board)
    board.valid_moves.sample
  end
end
