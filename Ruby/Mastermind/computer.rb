require_relative 'display'

# Computer player class
class Computer
  include Display # code_peg, code_peg_circle, and feedback_peg methods

  def initialize
    @code = []

    4.times do
      @code << rand(1..6)
    end

    p @code
  end

  def correct_code?(code)
    code == @code
  end

  def give_feedback(code)
    # 1. Start iterating over given code
    # 2. Is current number in the correct code?
    # 3a. Yes: see if current number is in the same position as it is in the correct code
    #     i. Yes: filled peg
    #     ii. No: empty peg
    # 3b. No: append N and return
    #
    # FIXME Doesn't work because 1 is still in @code but that triggers the elsif block,
    # which should not happen
    feedback = []

    code.each_with_index do |peg, index|
      if @code[index] == peg
        feedback << feedback_peg(true)
      elsif @code.include?(peg) && @code.index(peg) != index
        feedback << feedback_peg(false)
      else
        feedback << 'N'
      end
    end
    feedback.join
  end
end

a = Computer.new

p a.give_feedback([1, 1, 1, 1])
