require 'pry-byebug'

def caesar_cipher(initial_string, shift)
  initial_string.split('').map do |char|
    char = char.ord
    if char.between?(65, 90)
      char = (char + shift - 65) % 26 + 65
    elsif char.between?(97, 122)
      char = (char + shift - 97) % 26 + 97
    else
      char
    end
    char.chr
  end.join('')
end

puts caesar_cipher("What a string!", 6)
