# frozen_string_literal: true

# Allergies
class Allergies
  def allergic_to?(item)
    list.include?(item)
  end

  def list
    ITEMS.select.with_index do |_, index|
      (score & 2**index).positive?
    end
  end

  private

  ITEMS = %w[
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  ].freeze

  attr_reader :score

  def initialize(score)
    @score = score
  end
end
