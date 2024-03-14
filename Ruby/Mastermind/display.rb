# Module for displaying Mastermind pieces
module Display
  def code_peg(number, padding = 1, content = '')
    number = number.to_i unless number.instance_of?(Integer)
    spaces = ' ' * padding

    codes = {
      1 => "\e[41m#{spaces}#{content}#{spaces}\e[0m", # red
      2 => "\e[42m#{spaces}#{content}#{spaces}\e[0m", # green
      3 => "\e[43m#{spaces}#{content}#{spaces}\e[0m", # yellow
      4 => "\e[44m#{spaces}#{content}#{spaces}\e[0m", # blue
      5 => "\e[0;30m\e[47m#{spaces}#{content}#{spaces}\e[0m", # white
      6 => "\e[48;5;237m#{spaces}#{content}#{spaces}\e[0m" # black
    }

    codes[number]
  end

  def code_peg_circle(number)
    codes = {
      1 => '🔴', # red
      2 => '🟢', # green
      3 => '🟡', # yellow
      4 => '🔵', # blue
      5 => '⚪', # white
      6 => '⚫' # black
    }

    codes[number]
  end

  def feedback_peg(filled, padding = 0)
    spaces = ' ' * padding

    filled ? "#{spaces}●#{spaces}" : "#{spaces}○#{spaces}"
  end
end
