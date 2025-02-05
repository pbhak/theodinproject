# frozen-string-literal: true

# Core node class representing a node in a binary search tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other
  end
end
