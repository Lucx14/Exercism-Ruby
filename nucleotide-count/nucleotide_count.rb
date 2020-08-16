# frozen_string_literal: true

# Nucleotide
class Nucleotide
  VALID_NUCLEOTIDES = 'ATCG'
  attr_reader :dna

  def initialize(dna)
    @dna = dna
  end

  def self.from_dna(dna)
    raise ArgumentError if dna.match(/[^#{VALID_NUCLEOTIDES}]/)

    new(dna)
  end

  def count(nucleotide)
    dna.count(nucleotide)
  end

  def histogram
    VALID_NUCLEOTIDES.chars.map { |n| [n, count(n)] }.to_h
  end
end
