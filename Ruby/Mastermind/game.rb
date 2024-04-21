require_relative 'computer'
require 'pry-byebug'

# Contains functionality for the computer and the turn loop
class Game
  def initialize(player)
    @player = player

    valid_input = false
    valid_input_colors = false

    until valid_input_colors
      @player.colors = true
      print "Do you prefer colors [C] (#{@player.format_array([1, 2, 3, 4])})"
      @player.colors = false
      print " or numbers [N] (#{@player.format_array([1, 2, 3, 4])})? "

      case gets.chomp.upcase
      when 'C'
        puts 'Colors selected'
        @player.colors = true
        valid_input_colors = true
      when 'N'
        puts 'Numbers selected'
        @player.colors = false
        valid_input_colors = true
      else
        puts 'Invalid input, please enter either C or N'
        next
      end
    end

    until valid_input
      print 'Would you like to be the code-maker (CM) or the code-breaker (CB)? '

      case gets.chomp.upcase
      when 'CB'
        puts 'Code-breaker selected'
        valid_input = true
        start_cb
      when 'CM'
        puts 'Code-maker selected'
        valid_input = true
        start_cm
      else
        puts 'Invalid input, please enter either CB or CM'
        next
      end
    end
  end

  def start_cb
    @code = generate_code
    @code_counts = Hash.new(0)
    @code.each { |peg| @code_counts[peg] += 1 }

    turn = 1
    game_over = false
    until game_over
      if turn > 12
        puts 'Game over!'
        puts "The correct code was #{@player.format_array(@code)}"
        game_over = true
        next
      end

      puts "Turn ##{turn}"
      @player.place_guess

      puts 'Guess placed'

      feedback(@player.current_guess).each do |k, v|
        case k
        when :exact
          if v == 4
            puts "You win! The code was #{@player.format_array(@code)}"
            game_over = true
            break
          end

          puts "Amount of exact numbers: #{v}"
        when :near
          puts "Amount of close numbers: #{v}"
        when :none
          puts "Amount of failed numbers: #{v}"
        end
      end

      turn += 1

      @player.clear_guess
    end
  end

  def generate_code
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end

  def start_cm
    puts 'Set your code!'
    @player.place_guess('code')
    @code = @player.current_guess

    puts "Code set to #{@player.format_array(@code)}"

    @code_counts = Hash.new(0)
    @code.each { |peg| @code_counts[peg] += 1 }

    computer = Computer.new(self)
    puts 'Computer initialized'

    turn = 1
    game_over = false
    current_feedback = {}
    current_guess = []

    until game_over
      if turn > 12
        puts 'You win! The computer failed to guess your code!'
        puts "The code was #{@player.format_array(@code)}"
        game_over = true
        break
      end

      unless turn == 1
        puts 'Press Enter to proceed to next guess'
        gets
      end

      puts "Turn ##{turn}"
      puts "Computer placing guess...\r"
      current_guess = computer.place_guess(turn, current_guess, current_feedback)
      puts "Computer placed guess #{@player.format_array(current_guess)}"

      current_feedback = feedback(current_guess)

      current_feedback.each do |k, v|
        case k
        when :exact
          if v == 4
            puts "Computer wins! The code was #{@player.format_array(@code)}"
            game_over = true
            break
          end

          puts "Amount of exact #{@player.colors ? 'colors' : 'numbers'}: #{v}"
        when :near
          puts "Amount of close #{@player.colors ? 'colors' : 'numbers'}: #{v}"
        when :none
          puts "Amount of failed #{@player.colors ? 'colors' : 'numbers'}: #{v}"
        end
      end

      turn += 1
    end
  end

  def feedback(guess)
    guess_composition = {
      exact: 0,
      near: 0,
      none: 0
    }

    code_counts_dup = @code_counts.dup
    guess_counts = Hash.new(0)
    guess.each { |peg| guess_counts[peg] += 1 }

    guess.each_with_index do |peg, index|
      if @code[index] == peg
        # Exact match
        guess_composition[:exact] += 1
        code_counts_dup[peg] -= 1
        guess_counts[peg] -= 1
      elsif code_counts_dup[peg].positive? && code_counts_dup[peg] == guess_counts[peg]
        # Near match
        guess_composition[:near] += 1
        code_counts_dup[peg] -= 1
        guess_counts[peg] -= 1
      else
        # No match
        guess_composition[:none] += 1
      end
    end

    guess_composition
  end

  def get_index(index)
    @code[index] || 0
  end
end
