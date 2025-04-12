# frozen_string_literal: true

# Node class representing a node in a linked list
class Node
  attr_accessor :key, :next_node, :value

  def initialize(key, value = nil, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end

  def [](index)
    current_index = 0
    current_node = self
    until current_index == index || current_node.nil?
      current_node = current_node.next_node
      current_index += 1
    end

    current_node
  end
end

# Linked list, modified for hashmap
class LinkedList
  attr_reader :list, :size

  def initialize
    @list = nil
    @size = 0
  end

  def add(key, value = nil)
    node = Node.new(key, value)

    if @list.nil?
      @list = node
    else
      @list.next_node = node
    end

    @size += 1
    nil
  end

  def remove_node_if_exists(key) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    index = 0

    until index > (@size - 1)
      node = at(index)

      if node.key == key
        # Remove node
        if @list[0] == node
          # Node to remove is head
          @list = @list.next_node
        elsif at(index + 1).nil?
          # Node to remove is tail
          at(index - 1).next_node = nil
        else
          # Node to remove is in middle of list
          at(index - 1).next_node = at(index + 1)
        end

        @size -= 1
      end
      index += 1
    end
  end

  def contains?(key)
    current_node = @list

    until current_node.nil?
      return true if current_node.key == key

      current_node = current_node.next_node
    end

    false
  end

  def empty?
    size.zero?
  end

  def at(index)
    return nil if index > size - 1

    current_index = 0
    current_node = @list
    until current_index == index || current_node.nil?
      current_index += 1
      current_node = current_node.next_node
    end

    current_node
  end

  def [](index)
    at(index)
  end

  def clear!
    @list = nil
    @size = 0
  end

  def clear_node(node) # rubocop:disable Metrics/MethodLength
    current_node = @list

    until current_node.nil?
      if current_node.next_node == node
        if !node.next_node.nil? # rubocop:disable Style/ConditionalAssignment
          current_node.next_node = node.next_node
        else
          current_node.next_node = nil
        end

        @size -= 1
      end

      current_node = current_node.next_node
    end
  end

  def find(key)
    index = 0

    until index > size - 1
      return @list[index].value if @list[index].key == key

      index += 1
    end
    nil
  end
end
