# frozen_string_literal: true

# Binary search tree
class Bst
  attr_reader :data, :left, :right

  def initialize(data)
    @data = data
  end

  def insert(new_node)
    new_node <= data ? go_left(new_node) : go_right(new_node)
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    @left&.each(&block)
    yield data
    @right&.each(&block)
  end

  private

  def go_left(new_node)
    @left ? @left.insert(new_node) : @left = Bst.new(new_node)
  end

  def go_right(new_node)
    @right ? @right.insert(new_node) : @right = Bst.new(new_node)
  end
end
