# The player class
class Player
  attr_reader :name, :ready

  NUMBER_OF_SPACES = 3

  include RowsAndColumns

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @won = false
    @ready = false
  end

  # The turn loop
  def turn(board, board_string)
    unless DEBUG
      Gem.win_platform? ? system('cls') : system('clear')
    end

    puts "#{@name}'s turn: (#{@symbol})"
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
        puts 'Choose an unmarked square!'
        next
      end

      board[row][column] = @symbol

      break
    end
  end

  def won?(board)
    tie = false

    # Row win check
    return true if rows?(board) == true

    # Column win check
    return true if columns?(board) == true

    # Left-to-right diagonal win check
    return true if ltr_diagonals?(board) == true

    # Right-to-left diagonal win check
    return true if rtl_diagonals?(board) == true

    # Tie check
    if board.all? do |row|
         row.all? do |column|
           column != '-'
         end
       end

      tie = true
    end

    return 'tie' if tie

    false
  end
end
