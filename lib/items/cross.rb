require_relative "item"
require "colorize"

# A cross of tic tac toe
class Cross < Item
  def initialize(player)
    super
    @symbol = "X".colorize(:red)
  end
end
