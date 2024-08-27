require_relative "../items/board"

# A player that can play a turn, maybe in the future there
# are spectators, or several players that take turns
# or simply queues of players that can't play until later
module Playable
  def play_turn(board)
    puts "Player #{@player_id}'s turn".colorize(:blue)
    choice = choose_move(board)
    puts "Player #{@player_id}'s turn is over (#{choice}), current board state:"
    board.save_move(choice, @player)
    board.show_board
  end
end

# A player in the game
class Player
  attr_reader :player_id

  include Playable
  def initialize(player_id)
    @player_id = player_id
    @player = self
  end
end
