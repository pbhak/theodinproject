# require 'pry-byebug'

DEBUG = false

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
    'Both players need to be ready!' unless @player1.ready? && @player2.ready?

    # The game loop
    until @player1.won?(@board) || @player2.won?(@board)
      @player1.turn(@board, to_s)
      break if @player1.won?(@board)

      @player2.turn(@board, to_s)
    end

    # Tie handling
    if @player1.won?(@board) == 'tie' || @player2.won?(@board) == 'tie'
      puts "\n#{self}"
      puts "It's a tie!"
      return
    end

    puts "\n#{self}"
    puts @player1.won?(@board) ? "#{@player1.name} wins!" : "#{@player2.name} wins!"
  end
end

# Row and column manipulation, and the ready handler
module RowsAndColumns
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

  def rows?(board)
    board.each { |row| return true if row.all? { |slot| slot == @symbol } }
  end

  def columns?(board)
    column_list = board.each_with_object([[], [], []]) do |row, column|
      column[0] << row[0]
      column[1] << row[1]
      column[2] << row[2]
      column
    end
    column_list.each { |column| return true if column.all? { |slot| slot == @symbol } }
  end

  def ltr_diagonals?(board)
    ltr_diagonal_list = board.each_with_object([]) do |row, diagonal|
      diagonal << row[board.index(row)]
      diagonal
    end

    true if ltr_diagonal_list.all? { |slot| slot == @symbol }
  end

  def rtl_diagonals?(board)
    rtl_diagonal_list = board.each_with_object([]).with_index do |(row, diagonal), row_index|
      diagonal << if row_index == 1
                    row[row_index]
                  else
                    (row_index.zero? ? row[row_index + 2] : row[row_index - 2])
                  end

      diagonal
    end

    true if rtl_diagonal_list.all? { |slot| slot == @symbol }
  end

  def ready?
    number_of_nos = 0
    loop do
      puts "Is #{@name} #{@symbol} ready? (yes/no)"
      ready = gets.chomp.downcase

      case ready
      when 'yes'
        return true
      when 'no'
        number_of_nos += 1
        case number_of_nos
        when 0
          puts 'Wrong answer, try again'
        when 1
          puts 'Wrong answer, did you misclick?'
        when 2
          puts 'Are you doing this on purpose?'
        when 3
          puts 'You\'re really just trying to annoy me aren\'t you?'
        when 4
          puts 'Well, it turns out that computer programs don\'t get annoyed.'
        when 5
          puts 'You can\'t do this forever.'
        when 6
          puts 'This isn\'t benefitting either of us.'
        when 7
          puts 'I\'ll just keep saying the same thing until you eventually give up.'
        when 20
          puts 'You\'re probably just spamming at this point'
        when 30
          puts 'Ok this is enough'
          exit
        else
          puts 'Eggs.'
        end
      else
        puts 'Invalid response, try again'
      end
    end
  end
end

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

game = Game.new(Player.new('Fred', 'X'), Player.new('George', 'O'))
game.play
