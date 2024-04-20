require_relative 'game'
require_relative 'player'

# Class containing functionality for the computer, which uses the Knuth
# algorithm to solve a game of mastermind.
class Computer
  def initialize(game)
    @possible_solutions = calculate_all_solutions
    @game = game
  end

  # private

  def calculate_all_solutions
    final = []
    6.times do |i|
      i += 1
      6.times do |j|
        j += 1
        6.times do |k|
          k += 1
          6.times do |l|
            l += 1
            final << [i, j, k, l]
          end
        end
      end
    end

    final
  end

  def place_guess(turn, _last_guess, last_feedback)
    return [1, 1, 2, 2] if turn == 1

    @possible_solutions.select! do |solution|
      get_score(@game.feedback(solution)) > get_score(last_feedback)
    end

    sleep (3..6).to_a.sample

    @possible_solutions.sample
  end

  def get_score(feedback)
    score = 0

    feedback.each do |k, v|
      case k
      when :exact
        score += (3 * v)
      when :near
        score += (2 * v)
      when :none
        score += v
      end
    end

    score
  end
end
