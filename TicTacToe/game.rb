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
