require_relative "../players/player"

# An item on the board, representing O and X
class Item
  def initialize(player)
    @player = player
  end

  def to_s
    @symbol
  end

  def self.item_type(player_id)
    player_id.zero? ? Cross : Circle
  end
end
