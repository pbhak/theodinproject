<<<<<<< HEAD
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
=======
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

def swap(array)
  [array[1], array[0]]
end

def merge_sort(array)
  array = split_array(array)
  final_array = []
  
  array.each_with_index do |node, node_index|
    node.each_with_index do |subnode, subnode_index|
      if subnode.length == 2
        array[node_index][subnode_index] = swap(subnode) if subnode[0] > subnode[1]
      end
    end
  end
  
  array.each_with_index do |node, node_index|
    final_node = []
    
    4.times do
      if node[0][0] < node[1][0]
        final_node << node[0][0]
        node[0].shift
      elsif node[1][0] < node [0][0]
        final_node << node[1][0]
        node[1].shift
      end
      
      break if node[0].empty? and node[1].empty?
      if node[0].empty?
        final_node << node[1][0]
        break
      elsif node[1].empty?
        final_node << node[0][0]
        break
      end
    end
    
    final_array << final_node
  end
  array = [final_array]
  final_array = []
  
  array.each do |node|
    final_node = []
    loop do
      if node[0][0] < node[1][0]
        final_node << node[0][0]
        node[0].shift
      elsif node[1][0] < node [0][0]
        final_node << node[1][0]
        node[1].shift
      end
      
      break if node[0].empty? and node[1].empty?
      if node[0].empty?
        final_node << node[1][0]
        break
      elsif node[1].empty?
        final_node << node[0][0]
        break
      end
    end
    
    final_array << final_node
  end

  final_array[0]
end

p merge_sort([17, 33, 2, 77, 7, 9, 103])

>>>>>>> b8fbaddcfe9273c1e6cd6f00a4eb0333b09fbb9f
