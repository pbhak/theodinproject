# frozen_string_literal: true

# The game class
class Game
  def initialize(player1, player2)
    unless player1.is_a?(Player) && player2.is_a?(Player)
      puts 'You need to input two players!'
      return
    end

    @player1 = player1
    @player2 = player2
    @board = Array.new(3) { Array.new(3, '-') }
  end

  def to_s
    board_string = +'' # The plus sign unfreezes the stirng

    @board.each do |row|
      row.each do |column|
        board_string << "#{column}   "
      end
      board_string << "\n"
    end
    board_string
  end
end

class Player; end

game = Game.new(Player.new, Player.new)
puts game
