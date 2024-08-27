# An item on the board, representing O and X
class Item
  def initialize(player)
    @player = player
  end

  def to_s
    @symbol
  end

  def self.item_type(player)
    return Cross.new(player) if player.player_id.zero?

    Circle.new(player) if player.player_id == 1
  end

  def self.opposing_item_type(player)
    return Circle.new(player) if player.player_id.zero?

    Cross.new(player) if player.player_id == 1
  end
end
