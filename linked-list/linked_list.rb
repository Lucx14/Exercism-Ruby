# frozen_string_literal: true

# Element
class Element
  attr_reader :datum
  attr_accessor :previous, :next
  def initialize(datum)
    @datum = datum
  end
end

# Linked list
class Deque
  def initialize
    @head = nil
  end

  def push(element)
    if @head.nil?
      @head = Element.new(element)
    else
      new_element = Element.new(element)
      new_element.previous = @head
      @head.next = new_element
      @head = new_element
    end
  end

  def pop
    return if @head.nil?

    popped_element = @head
    @head = popped_element.previous
    @head.next = nil if @head
    popped_element.datum
  end

  def shift
    return nil if @head.nil?

    first = first_element
    second = first.next
    if second
      second.previous = nil
    else
      @head = nil
    end
    first.datum
  end

  def unshift(element)
    return push(element) if @head.nil?

    new_element = Element.new(element)
    first = first_element
    new_element.next = first
    first.previous = new_element
  end

  def first_element
    looker = @head
    looker = looker.previous until looker.previous.nil?
    looker
  end
end
