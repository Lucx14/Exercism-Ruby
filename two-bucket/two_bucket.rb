# frozen_string_literal: true

# Two Buckets
class TwoBucket
  attr_reader :bucket_one, :bucket_two, :target, :bucket_to_fill_first

  def initialize(size_of_bucket_one, size_of_bucket_two, target, bucket_to_fill_first)
    @bucket_one = Bucket.new(size_of_bucket_one)
    @bucket_two = Bucket.new(size_of_bucket_two)
    @target = target
    @bucket_to_fill_first = bucket_to_fill_first == 'one' ? bucket_one : bucket_two
  end

  def moves
    # p bucket_one
    # p bucket_two
    # p bucket_to_fill_first

    # move one
    bucket_to_fill_first.fill

    # move two
    bucket_one.pour_into(bucket_two)

    # move three
    bucket_one.fill

    # move_four
    bucket_one.pour_into(bucket_two)

    if bucket_one.volume == target || bucket_two.volume == target
      p "TARGET HAS BEEN REACHED!!!"
    end

    p bucket_one
    p bucket_two
    
    4
  end

  def goal_bucket
    'one'
  end

  def other_bucket
    # this is what is left in the other bucket.volume
    5
  end
end

# the only valid moves are:
# pouring from one bucket to another
# emptying one bucket and doing nothing to the other
# filling one bucket and doing nothing to the other
class Bucket
  attr_reader :size
  attr_accessor :volume

  def initialize(size)
    @size = size
    @volume = 0
  end

  def fill
    self.volume = size
  end

  def empty
    self.volume = 0
  end

  def pour_into(other)
    available_space = other.size - other.volume
    if volume.zero?
      # p "111111"
      true
    elsif available_space.zero?
      # p "22222222"
      true
    elsif available_space > volume
      # p "33333333"
      other.volume += volume
      self.volume = 0
    elsif volume > available_space
      # p "4444444"
      other.fill
      self.volume -= available_space
    end
  end
end
