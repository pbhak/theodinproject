# Contains functionality for the computer and the turn loop
class Game
  def initialize
    @code = generate_code
    @code_counts = Hash.new(0)
    @code.each { |peg| @code_counts[peg] += 1 }
    p @code
  end

  # private

  def generate_code
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end

  def feedback(guess)
    guess_composition = {
      exact: 0,
      near: 0,
      none: 0
    }

    guess_counts = Hash.new(0)
    guess.each { |peg| guess_counts[peg] += 1 }

    guess.each_with_index do |peg, index|
      if @code[index] == peg
        # Exact match
        guess_composition[:exact] += 1
      elsif @code_counts[peg].positive?
        # Near match
        guess_composition[:near] += 1
      else
        # No match
        guess_composition[:none] += 1
      end
    end

    guess_composition
  end
end
