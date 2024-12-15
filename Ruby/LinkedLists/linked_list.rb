# frozen_string_literal: true

require_relative 'node'

# Linked list
class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    @head = Node.new(value) if @head.nil?
  end
end
