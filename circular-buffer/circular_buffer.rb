# frozen_string_literal: true

# Circular Buffer
class CircularBuffer
  class BufferEmptyException < StandardError; end

  attr_reader :num

  def initialize(num)
    @num = num
  end

  def read
    raise CircularBuffer::BufferEmptyException
  end
end
