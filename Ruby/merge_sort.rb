def split_array(array)
  return array if array.length <= 2
  
  final_array = []
  loop do
    break if array.empty?
    if array[0] && array[1]
      final_array << [array.shift(), array.shift()]
    else
      final_array << [array.shift()]
    end
  end
  
  loop do
    break if final_array.empty?
    if final_array[0] && final_array[1]
      array << [final_array.shift(), final_array.shift()]
    else
      final_array << [array.shift()]
    end
  end
  
  array
end

def merge_sort(array)
  split_array array
end

p merge_sort([33, 17, 2, 77, 7, 9, 103])