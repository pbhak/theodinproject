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

  def insert(item, node = @root)
    return Node.new(item) if node.nil?
    return node if node == item

    node.right = insert(item, node.right) if node < item
    node.left = insert(item, node.left) if node > item

    node
  end

  def delete(item)
    node = @root
    parent_node = nil
    until node.left == item || node.right == item
      parent_node = node
      node = node.left if node > item
      node = node.right if node < item
    end

    # Case 1 - node is a leaf node
    if node.leaf_node?
      node.right = nil if node < item
      node.left = nil if node > item
    end

    # Case 2 - node has one child
    if node.children == 1
      left = node.right.nil?

      if left
        node.data = node.left
        node.left = nil
      else
        node.data = node.right
        node.right = nil
      end
    end

    # Case 3 - node has two children
    successor = inorder_successor(@root)
    @root.data = successor.data
    item.right = delete(successor.data)
  end

  def inorder_successor(node)
    node = node.right
    node = node.left until node.leaf_node?
    node
  end
end

r = Tree.new([50])
r.insert(30)
r.insert(20)
r.insert(40)
r.insert(70)
r.insert(60)
r.insert(80)

r.delete 80
r.pretty_print