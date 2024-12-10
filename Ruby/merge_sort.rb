require 'pry-byebug'

def merge_sort(unsorted_arr)
  return unsorted_arr if unsorted_arr.length <= 1

  middle_of_arr = unsorted_arr.length / 2 # Ruby automatically rounds down

  left_arr = unsorted_arr[0..middle_of_arr]
  right_arr = unsorted_arr[middle_of_arr + 1..]

  merge(left_arr)
  merge(right_arr)
end

def merge(arr, second_arr = nil)
  middle_of_arr = arr.length / 2
  left_arr = arr[0..middle_of_arr]
  right_arr = arr[middle_of_arr + 1..]
end

merge_sort([3, 2, 1, 13, 8, 5, 0, 1])
