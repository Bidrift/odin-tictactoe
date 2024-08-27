require_relative "../players/player"
require_relative "item"
require_relative "circle"
require_relative "cross"

# This is the board of the game
class Board
  def initialize(board_size = 3, board = Array.new(3) { Array.new(3) })
    @board_size = board_size
    @board = board
  end

  def show_board
    @board.each_with_index do |v, k|
      puts v.each_with_index.map { |v2, k2| v2 || ((k * @board_size) + k2 + 1) }.join(" | ")
    end
  end

  def save_move(choice, player)
    move = Item.item_type(player)
    put_item(choice, move)
  end

  def valid_moves
    @board.flatten.each_with_index.reject { |v| v[0] }.map { |v| v[1] + 1 }
  end

  def valid?(choice)
    !@board[(choice - 1) / 3][(choice - 1) % 3]
  end

  def clear
    @board = Array.new(3) { Array.new(3) }
  end

  def over?
    check_rows || check_columns || check_diagonals
  end

  def full?
    @board.all? { |v| v.none?(&:!) }
  end

  def winning_move?(choice, player)
    move = Item.item_type(player)
    put_item(choice, move)
    over = over?
    put_item(choice, nil)
    over
  end

  def losing_move?(choice, player)
    move = Item.opposing_item_type(player)
    put_item(choice, move)
    over = over?
    put_item(choice, nil)
    over
  end

  private

  def put_item(choice, move)
    @board[(choice - 1) / 3][(choice - 1) % 3] = move
  end

  def check_rows
    @board.find { |v| v.map(&:class).compact.uniq.size == 1 && v.compact.size == 3 }
  end

  def check_columns
    result = nil
    @board.each_index do |k|
      result ||= @board.map { |v| v[k] }.map(&:class).compact.uniq.size == 1 && @board.map do |v|
        v[k]
      end.compact.size == 3
    end
    result
  end

  def check_diagonals
    diagonals = [[[0, 0], [1, 1], [2, 2]], [[2, 0], [1, 1], [0, 2]]]
    diagonals.find do |diagonal|
      diagonal.map { |v1, v2| @board[v1][v2] }.map(&:class).compact.uniq.size == 1 && diagonal.map do |v1, v2|
        @board[v1][v2]
      end.compact.size == 3
    end
  end
end
