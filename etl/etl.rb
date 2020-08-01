# frozen_string_literal: true

# Etl
module ETL
  def self.transform(data)
    data.flat_map { |k, v| v.map(&:downcase).product([k]) }.to_h
  end
end
