# The game class
class Game
  NUMBER_OF_SPACES = 3

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
    board_string = ''

    @board.each do |row|
      row.each do |column|
        board_string << column + (' ' * NUMBER_OF_SPACES)
      end
      board_string << "\n"
    end
    board_string
  end

  def play
    'Both players need to be ready!' unless @player1.ready && @player2.ready

    # The game loop
    until @player1.won || @player2.won
      @player1.turn(@board, to_s)
      @player2.turn(@board, to_s)
    end
  end
end

# The player class
class Player
  attr_reader :ready, :won

  NUMBER_OF_SPACES = 3

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @ready = false
    @won = false
  end

  def column_input(index, row)
    case row
    when 0
      index - 1
    when 1
      index - 4
    when 2
      index - 7
    end
  end

  def row_and_column
    index = ''
    loop do
      print 'Index: '
      index = gets.chomp.to_i
      break if index.between?(1, 9)

      (puts 'Index needs to be valid!' unless index.between?(1, 9))
    end
    case index
    when 1..3
      [0, column_input(index, 0)]
    when 4..6
      [1, column_input(index, 1)]
    when 7..9
      [2, column_input(index, 2)]
    end
  end

  # The turn loop
  def turn(board, board_string)
    puts "#{@name}'s turn:"
    puts board_string
    puts 'Enter an index according to the guide below: '

    9.times do |number|
      number += 1
      print number.to_s + (' ' * NUMBER_OF_SPACES)
      print "\n" if (number % 3).zero?
    end

    loop do
      r_and_c = row_and_column # Calling the function twice for vars would cause double input

      row = r_and_c[0]
      column = r_and_c[1]

      unless board[row][column] == '-'
        puts 'Choose a square you haven\'t marked yet!'
        next
      end

      board[row][column] = @symbol

      p board[row][column]
      break
    end
  end

  def won?
    # Checks to implement
    # TODO row win checks
    # TODO column win checks
    # TODO left-to-right diagonal win checks
    # TODO right-to-left diagonal win checks
  end
end

game = Game.new(Player.new('Fred', 'X'), Player.new('George', 'O'))
game.play
