# Row and column manipulation, and the ready handler
module RowsAndColumns
  def column_input(index, row)
    case row
    when 0
      index - 1
    when 1
      index - 4
    when 2
      index - 7
    end
  end

  def row_and_column
    index = ''
    loop do
      print 'Index: '
      index = gets.chomp.to_i
      break if index.between?(1, 9)

      (puts 'Index needs to be valid!' unless index.between?(1, 9))
    end
    case index
    when 1..3
      [0, column_input(index, 0)]
    when 4..6
      [1, column_input(index, 1)]
    when 7..9
      [2, column_input(index, 2)]
    end
  end

  def rows?(board)
    board.each { |row| return true if row.all? { |slot| slot == @symbol } }
  end

  def columns?(board)
    column_list = board.each_with_object([[], [], []]) do |row, column|
      column[0] << row[0]
      column[1] << row[1]
      column[2] << row[2]
      column
    end
    column_list.each { |column| return true if column.all? { |slot| slot == @symbol } }
  end

  def ltr_diagonals?(board)
    ltr_diagonal_list = board.each_with_object([]) do |row, diagonal|
      diagonal << row[board.index(row)]
      diagonal
    end

    true if ltr_diagonal_list.all? { |slot| slot == @symbol }
  end

  def rtl_diagonals?(board)
    rtl_diagonal_list = board.each_with_object([]).with_index do |(row, diagonal), row_index|
      diagonal << if row_index == 1
                    row[row_index]
                  else
                    (row_index.zero? ? row[row_index + 2] : row[row_index - 2])
                  end

      diagonal
    end

    true if rtl_diagonal_list.all? { |slot| slot == @symbol }
  end

  def ready?
    number_of_nos = -1
    loop do
      print "Is #{@name} (#{@symbol}) ready? (yes/no) "
      ready = gets.chomp.downcase

      case ready
      when 'yes'
        return true
      when 'no'
        number_of_nos += 1
        case number_of_nos
        when 0
          puts 'Wrong answer, try again'
        when 1
          puts 'Wrong answer, did you misclick?'
        when 2
          puts 'Are you doing this on purpose?'
        when 3
          puts 'You\'re really just trying to annoy me aren\'t you?'
        when 4
          puts 'Well, it turns out that computer programs don\'t get annoyed.'
        when 5
          puts 'You can\'t do this forever.'
        when 6
          puts 'This isn\'t benefitting either of us.'
        when 7
          puts 'I\'ll just keep saying the same thing until you eventually give up.'
        when 20
          puts 'You\'re probably just spamming at this poin.t'
        when 30
          puts 'Ok that\'s enough.'
          exit
        else
          puts 'Eggs.'
        end
      else
        puts 'Invalid response, try again.'
      end
    end
  end
end
