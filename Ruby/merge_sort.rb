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
  
  array.each_with_index do |node, node_index|
    node.each_with_index do |subnode, subnode_index|
      if subnode.length == 2
        array[node_index][subnode_index] = swap(subnode) if subnode[0] > subnode[1]
      end
    end
  end
  
  array
end

p merge_sort([17, 33, 2, 77, 7, 9, 103])
