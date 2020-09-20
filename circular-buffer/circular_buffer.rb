# frozen_string_literal: true

# Circular Buffer
class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  attr_reader :size, :buffer

  def initialize(size)
    @size = size
    @buffer = []
  end

  def write(data)
    raise CircularBuffer::BufferFullException if full?

    buffer << data
  end

  def read
    raise CircularBuffer::BufferEmptyException if buffer.empty?

    buffer.shift
  end

  def write!(data)
    read if full?

    write(data)
  end

  def clear
    buffer.clear
  end

  private

  def full?
    buffer.size == size
  end
end
