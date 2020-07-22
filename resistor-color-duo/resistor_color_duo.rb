# frozen_string_literal: true

# Resistor Duo
module ResistorColorDuo
  BANDS = %w[black brown red orange yellow green blue violet grey white].freeze

  def self.value(pair)
    (
      BANDS.index(pair[0]).to_s + BANDS.index(pair[1]).to_s
    ).to_i
  end
end
