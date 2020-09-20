# frozen_string_literal: true

# Circular Buffer
class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  attr_reader :size, :buffer

  def initialize(size)
    @size = size
    @buffer = (1..size).map { [] }
  end

  def write(data)
    raise CircularBuffer::BufferFullException if empty_nodes.zero?

    buffer.detect(&:empty?) << data
  end

  def read
    raise CircularBuffer::BufferEmptyException if empty_nodes == size

    buffer.rotate!
    buffer.last.pop
  end

  def write!(data)
    return write(data) unless empty_nodes.zero?

    buffer.rotate!
    buffer.last.pop
    buffer.last << data
  end

  def clear
    buffer.each(&:pop)
  end

  private

  def empty_nodes
    buffer.select(&:empty?).size
  end
end
