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
      node.next_node = @tail
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
    current_node = @tail

    until current_node.nil?
      size += 1
      current_node = current_node.next_node
    end

    size
  end

  def to_s
    current_node = @tail

    until current_node.nil?
      print "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    puts 'nil'
  end
end
