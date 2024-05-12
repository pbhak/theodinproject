def generate_word(words_file)
  all_words = []

  File.open(words_file, 'r') do |file|
    file.each_line do |line|
      line = line.chomp
      all_words << line.downcase if line.length >= 5 && line.length <= 12
    end
  end

  all_words.sample
end

def place_guess(word, guessed_letters)
  # Returns true if guess successful, false if game is finished
  word_display = word.split('')

  word_display.map! do |char|
    if guessed_letters.include?(char)
      char
    else
      '_'
    end
  end

  puts word_display.join(' ')
  return false unless word_display.include?('_')

  true
end

# Main game
word = generate_word('words.txt')
guessed_letters = []
guesses_left = 6


# Make this the game loop
puts "You have #{guesses_left} guesses left (#{word})"
puts # Second newline

guess = ''

loop do
  print 'Enter your guess: '
  guess = gets.chomp.downcase

  if guess.length != 1 || !guess.ord.between?(97, 122)
    puts 'Invalid guess!'
    next
  elsif guessed_letters.include?(guess)
    puts 'Already guessed!'
    next
  end

  guessed_letters << guess
  unless place_guess(word, guessed_letters)
    puts 'Game over!'
    exit
  end
end


# TODO add stick figure
# TODO make turn loop
# TODO rest of functionality
