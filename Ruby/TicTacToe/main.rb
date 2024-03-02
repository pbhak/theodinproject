DEBUG = false

require_relative 'game'
require_relative 'rows_and_cols'
require_relative 'player'

require 'pry-byebug' if DEBUG

print 'What will be X\'s name? '
player1 = Player.new(gets.chomp, 'X')

print 'What will be O\'s name? '
player2 = Player.new(gets.chomp, 'O')

game = Game.new(player1, player2)
game.play
