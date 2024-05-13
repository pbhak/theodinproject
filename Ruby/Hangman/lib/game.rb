require 'json'

# The primary Hangman game class
class Game
  def initialize
    @current_guess = ''
    @guessed_letters = []
    @number_of_guesses = 1
    @start_time = Time.now.to_i
    @word = generate_word('words.txt')
    # TODO add savefile recognition
  end

  private

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

  def guess_word
    final_guess = ''
    loop do
      print 'Enter your guess: '
      final_guess = gets.chomp.downcase

      if final_guess.empty?
        puts 'Invalid guess!'
        next
      else
        break
      end
    end

    return true if final_guess == @word

    puts "The word was not #{final_guess.upcase}!"
    puts
    @number_of_guesses += 1

    false
  end

  def place_guess
    # Returns true if guess successful, false if game is finished
    word_display = @word.split('')

    return false if (word_display - @guessed_letters).empty?

    word_display.map! do |char|
      if @guessed_letters.include?(char)
        char
      else
        '_'
      end
    end

    puts word_display.join(' ')
    puts

    true
  end

  def elapsed_seconds
    Time.now.to_i - @start_time
  end

  def to_json(*options)
    current_state = {
      current_guess: @current_guess,
      guessed_letters: @guessed_letters,
      number_of_guesses: @number_of_guesses,
      start_time: @start_time,
      save_time: Time.now.to_i,
      word: @word
    }

    JSON.pretty_generate(current_state)
  end

  def save
    File.open('save.json', 'w') do |file|
      file.write(to_json)
    end
  end

  def load_save
    saved_state = {}
    File.open('save.json', 'r') do |file|
      saved_state = JSON.parse(file.read)
    end

    # Deserialization
    @current_guess = saved_state['current_guess']
    @guessed_letters = saved_state['guessed_letters']
    @number_of_guesses = saved_state['number_of_guesses']
    @start_time = Time.now.to_i - (saved_state['save_time'] - saved_state['start_time'])
    @word = saved_state['word']
  end

  public

  def start
    @word.length.times do
      print '_ '
    end
    puts "\n\n"

    loop do # Primary game loop
      # puts "You are on guess number #{@number_of_guesses} (#{@word})"
      puts "You are on guess number #{@number_of_guesses} - #{elapsed_seconds} seconds elapsed"

      unless @guessed_letters.empty?
        print 'Letters guessed: '
        @guessed_letters.each do |letter|
          print letter.upcase
          print ', ' unless letter == @guessed_letters.last
        end
        puts
        puts
      end

      print 'Enter your guess, or press ENTER to guess the word: '
      @current_guess = gets.chomp.downcase
      puts

      if @current_guess.empty?
        if guess_word
          puts "\nYou win! The word was #{@word.upcase}"
          puts "Took #{@number_of_guesses} guesses and #{elapsed_seconds} seconds"
          break
        else
          next
        end
      elsif @current_guess.length != 1 || !@current_guess.ord.between?(97, 122)
        puts 'Invalid guess!'
        next
      elsif @guessed_letters.include?(@current_guess)
        puts 'Already guessed!'
        next
      end

      @guessed_letters << @current_guess
      @guessed_letters.sort!

      @number_of_guesses += 1

      if place_guess == false
        puts "\nYou win! The word was #{@word.upcase}"
        puts "Took #{@number_of_guesses} guesses and #{elapsed_seconds} seconds"
        break
      end

      save
    end
  end
end
