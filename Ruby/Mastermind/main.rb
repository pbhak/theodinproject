require_relative 'game'

game = Game.new
guess = []

4.times do |i|
  print "Guess #{i + 1}: "
  guess << gets.chomp.to_i
end

p game.feedback(guess)
