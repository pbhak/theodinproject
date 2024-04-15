# Contains functionality for the computer and the turn loop
class Game
  def initialize
    @code = generate_code
    p @code
  end

  def generate_code
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end
end
