# Contains functionality for the human player
class Player
  attr_reader :current_guess


  def initialize
    @current_guess = []
    @colors = false
    @color_list = %w[🔴 🔵 🟢 🟠 🟣 🟡]
  end

  def place_guess(string = 'guess')
    ordinal_numbers = %w[first second third fourth]

    4.times do |i|
      proceed_guess = false

      unless @current_guess.empty?
        puts "Your #{string} so far: #{format_array(@current_guess)}"
      end

      until proceed_guess
        print "Enter the #{ordinal_numbers[i]} number: "
        input = gets.chomp.to_i
        proceed_guess = true if input.is_a?(Integer) && input.between?(1, 6)

        unless proceed_guess
          puts 'Please make sure your input is a number between 1 and 6.'
          next
        end

        @current_guess << input
      end

      Gem.win_platform? ? system('cls') : system('clear')
    end
  end

  def clear_guess
    @current_guess = []
  end

  def format_array(array, colors = false)
    @colors = colors unless colors == @colors

    puts "@colors = #{@colors}"

    return array.join(' • ') unless colors

    array.map { |index| @color_list[index - 1] }.join(' • ')
  end
end
