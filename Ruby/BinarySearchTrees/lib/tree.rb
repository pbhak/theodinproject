# frozen_string_literal: true

require_relative 'node'

# Class representing a balanced binary search tree
class Tree
  def initialize(array)
    @array = array.sort.uniq
    @root = nil
    build_tree
  end

  def build_tree(array = @array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid + 1)..])

    @root = root
    @root
  end

  def insert(value, current_node = @root) # TODO: test and fix this later
    node = Node.new(value)
    current_value = current_node.data
    
    if current_value > node
      if current_node.left.nil?
        current_node.left = node
      else
        insert(value, current_node.left)
      end
    elsif current_value < node
      if current_node.right.nil?
        current_node.right = node
      else
        insert(value, current_node.right)
      end
    end
  end
end

