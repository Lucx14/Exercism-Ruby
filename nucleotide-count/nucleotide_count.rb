# frozen_string_literal: true

# Nucleotide
class Nucleotide
  attr_reader :histogram

  def initialize(dna)
    raise ArgumentError if dna.match(/[^CAGT]/)

    @histogram = build_histogram(dna)
  end

  def self.from_dna(dna)
    new(dna)
  end

  def count(nucleotide)
    histogram[nucleotide]
  end

  private

  def build_histogram(dna)
    histogram = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
    dna.chars.each { |nucleotide| histogram[nucleotide] += 1 }
    histogram
  end
end
