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

# def caesar_cipher(initial_string, shift)
#   downcase_array = ('a'..'z').to_a
#   upcase_array = ('A'..'Z').to_a

#   string_array = initial_string.split('')

#   string_array.map do |char|
#     if !char.match(/[[:alpha:]]/)
#       next
#     elsif char == char.downcase
#       if (downcase_array.index(char) + shift) <= 25
#         string_array[string_array.index(char)] = downcase_array[downcase_array.index(char) + shift]
#       else
#         string_array[string_array.index(char)] = downcase_array[(downcase_array.index(char) + shift) - 26]
#       end
#     elsif char == char.upcase
#       if (upcase_array.index(char) + shift) <= 25
#         string_array[string_array.index(char)] = upcase_array[upcase_array.index(char) + shift]
#       else
#         string_array[string_array.index(char)] = upcase_array[(upcase_array.index(char) + shift) - 26]
#       end
#     end
#   end
#   string_array.join('')
# end

puts caesar_cipher("What a string!", 6)
