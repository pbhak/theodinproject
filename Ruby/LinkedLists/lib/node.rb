# frozen_string_literal: true

# Node class representing each node in a linked list
class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    "(#{@value})"
  end
end
