# frozen_string_literal: true

require_relative 'node'

# Linked list
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(node)
    node = Node.new(node)

    if @head.nil?
      @head = node
    else
      @tail.next_node = node
    end

    @tail = node
  end

  def prepend(node)
    node = Node.new(node)

    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  def size
    return nil if @head.nil?
    return 1 if @head == @tail

    size = 0
    current_node = @head

    until current_node.nil?
      size += 1
      current_node = current_node.next_node
    end

    size
  end

  def at(index)
    return nil if index > size - 1

    current_index = 0
    current_node = @head
    until current_index == index || current_node == @tail
      current_index += 1
      current_node = current_node.next_node
    end

    current_node
  end

  def pop # rubocop:disable Metrics/MethodLength
    if size <= 1
      @head = nil
      @tail = nil
      return nil
    end

    current_node = @head
    popped_node = @tail

    current_node = current_node.next_node until current_node.next_node == @tail

    current_node.next_node = nil
    @tail = current_node

    popped_node.value
  end

  def contains?(value)
    current_node = @head

    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_index = 0
    current_node = @head

    until current_node.nil?
      return current_index if current_node.value == value

      current_index += 1
      current_node = current_node.next_node
    end

    nil
  end

  def insert_at(value, index)
    return nil if at(index).nil?

    value = Node.new(value)
    previous_node = at(index - 1)
    next_node = at(index)

    value.next_node = next_node
    previous_node.next_node = value
  end

  def remove_at(index)
    return nil if at(index).nil? || at(index) == @tail || at(index) == @head

    previous_node = at(index - 1)
    next_node = at(index + 1)

    previous_node.next_node = next_node
  end

  def to_s
    current_node = @head

    until current_node.nil?
      print "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    puts 'nil'
  end
end
