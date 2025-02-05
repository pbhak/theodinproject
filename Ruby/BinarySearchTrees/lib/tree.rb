# frozen-string-literal: true

require_relative 'node'

# Class representing a binary search tree
class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array, start_index = 0, end_index = array.sort.uniq.length - 1)
    array = array.sort.uniq

    return nil if start_index > end_index

    mid = (start_index + end_index) / 2

    root = Node.new(array[mid])
    root.left = build_tree(array, start_index, mid - 1)
    root.right = build_tree(array, mid + 1, end_index)

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

x = Tree.new([])
