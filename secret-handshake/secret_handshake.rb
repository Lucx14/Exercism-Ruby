# frozen_string_literal: true

# Secret Handshake
class SecretHandshake
  EVENTS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze

  attr_reader :decimal

  def initialize(decimal)
    @decimal = decimal
  end

  def commands
    return [] unless decimal.is_a? Integer

    events = decimal.to_s(2).chars.reverse.map(&:to_i).each_with_index.map do |number, i|
      EVENTS[i] if number == 1
    end.compact
    decimal.to_s(2).length > 4 ? events.reverse : events
  end
end
