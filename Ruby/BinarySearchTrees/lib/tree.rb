# frozen-string-literal: true

require_relative 'node'

# Class representing a binary search tree
class Tree
  attr_accessor :root
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

  def insert(item, node = @root)
    return Node.new(item) if node.nil?
    return node if node == item

    node.right = insert(item, node.right) if node < item
    node.left = insert(item, node.left) if node > item

    node
  end

  def delete(item, node = @root)
    return nil if node.nil?

    if node > item
      node.left = delete(item, node.left)
    elsif node < item
      node.right = delete(item, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      succ = inorder_successor(node)
      node.data = succ.data
      node.right = delete(succ.data, node.right)
    end 

    node
  end

  def inorder_successor(node = @root)
    node = node.right
    node = node.left until node.leaf_node?
    node
  end
end

r = Tree.new([50, 30, 70, 20, 40, 60, 80])
loop do
  eval(gets.chomp)
  r.pretty_print
end