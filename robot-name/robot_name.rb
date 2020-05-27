# frozen_string_literal: true

# Robot class
class Robot
  ROBOT_NAMES = ('AA000'..'ZZ999').to_a
  @@robot_names = ROBOT_NAMES.clone.shuffle

  attr_reader :name

  def initialize
    generate_name
  end

  def self.forget
    @@robot_names = ROBOT_NAMES.clone.shuffle
  end

  def reset
    generate_name
  end

  private

  def generate_name
    @name = @@robot_names.pop
  end
end
