# frozen_string_literal: true

# Binary search tree
class Bst
  attr_reader :data, :nodes
  attr_accessor :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
    @nodes = [data]
  end

  def insert(new_node)
    nodes << new_node
    if new_node <= data
      left ? left.insert(new_node) : self.left = Bst.new(new_node)
    else
      right ? right.insert(new_node) : self.right = Bst.new(new_node)
    end
  end

  def each(&block)
    nodes.sort.each(&block)
  end

  # def new_node(direction, new_node)
  #   direction ? direction.insert(new_node) : self.direction = Bst.new(new_node)
  # end
end
