require_relative "item"
require "colorize"

# A circle of tic tac toe
class Circle < Item
  def initialize(player = Computer.new(1))
    super
    @symbol = "O".colorize(:yellow)
  end
end
