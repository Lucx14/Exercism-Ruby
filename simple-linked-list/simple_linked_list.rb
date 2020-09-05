# frozen_string_literal: true

require 'pry'

# Element
class Element
  attr_reader :datum
  attr_accessor :next

  def initialize(datum)
    @datum = datum
  end
end

# Simple Linked List
class SimpleLinkedList
  def initialize(array = [])
    @head = nil
    array.each { |element| push(Element.new(element)) }
  end

  def push(element)
    element.next = @head if @head
    @head = element

    self
  end

  def pop
    popped_element = @head if @head
    @head = @head ? @head.next : nil

    popped_element
  end

  def to_a
    arr = []
    element = @head
    while element
      arr << element.datum
      element = element.next
    end
    arr
  end

  def reverse!
    new_head = nil

    while @head
      next_el = @head.next
      @head.next = new_head
      new_head = @head

      @head = next_el
    end

    @head = new_head
    self
  end
end
