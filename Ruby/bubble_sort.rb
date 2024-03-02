# require 'pry-byebug'

def swap!(array, elem1, elem2)
  array[elem1], array[elem2] = array[elem2], array[elem1]
end

def bubble_sort(array)
  sort = true

  while sort do
    array.map.with_index do |number, index|
      next_number = array[index + 1]
      break if next_number.nil?

      if number <= next_number
        next
      elsif number > next_number
        swap!(array, index, index + 1)
      else
        puts "Something went wrong"
      end
    end

    passes = 0

    array.each_with_index do |number, index|
      break if array[index + 1].nil?
      next if number > array[index + 1] # Re-sort if the array is not yet fully sorted
      passes += 1
    end

    break if passes == (array.length - 1) # Stop sorting and return the array if it is fully sorted
  end
  array
end

unsorted_array_1 = [5, 2, 9, 1, 5, 6, 3, 8, 4, 7]
unsorted_array_2 = [10, 8, 3, 6, 1, 9, 4, 7, 2, 5]
unsorted_array_3 = [15, 12, 19, 11, 15, 16, 13, 18, 14, 17]

p bubble_sort(unsorted_array_1)
p bubble_sort(unsorted_array_3)
p bubble_sort(unsorted_array_3)

unsorted_array_4 = [5.3, 2.1, 9.7, 1.4, 5.6, 6.9, 3.2, 8.5, 4.8, 7.0]
unsorted_array_5 = [10.2, 8.4, 3.9, 6.5, 1.7, 9.1, 4.3, 7.8, 2.6, 5.0]
unsorted_array_6 = [15.6, 12.3, 19.8, 11.1, 15.4, 16.9, 13.2, 18.5, 14.7, 17.0]

p bubble_sort(unsorted_array_4)
p bubble_sort(unsorted_array_5)
p bubble_sort(unsorted_array_6)
