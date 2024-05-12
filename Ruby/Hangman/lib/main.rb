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
  puts
  return false unless word_display.include?('_')

  true
end

def guess_word(word)
  print 'Enter your guess: '
  final_guess = gets.chomp.downcase

  return true if final_guess == word

  false
end

# Main game
word = generate_word('words.txt')
guessed_letters = []
guesses_left = 6


until guesses_left.zero?
  puts "You have #{guesses_left} guesses left (#{word})"
  unless guessed_letters.empty?
    print 'Letters guessed: '
    guessed_letters.each do |letter|
      print letter.upcase
      print ', ' unless letter == guessed_letters.last
    end
    puts
    puts
  end

  guess = ''

  print 'Enter your guess, or press ENTER to guess the word: '
  guess = gets.chomp.downcase
  puts

  if guess == ''
    if guess_word(word)
      puts
      puts "You win! The word was #{word}"
      break
    end
  elsif guess.length != 1 || !guess.ord.between?(97, 122)
    puts 'Invalid guess!'
    next
  elsif guessed_letters.include?(guess)
    puts 'Already guessed!'
    next
  end

  guessed_letters << guess
  guesses_left -= 1

  unless place_guess(word, guessed_letters)
    puts "\nGame over! The word was #{word}"
    exit
  end
end
