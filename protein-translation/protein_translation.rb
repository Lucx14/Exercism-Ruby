# frozen_string_literal: true

class InvalidCodonError < StandardError; end
# Translation
module Translation
  CODONS = {
    Methionine: %i[AUG],
    Phenylalanine: %i[UUU UUC],
    Leucine: %i[UUA UUG],
    Serine: %i[UCU UCC UCA UCG],
    Tyrosine: %i[UAU UAC],
    Cysteine: %i[UGU UGC],
    Tryptophan: %i[UGG],
    STOP: %i[UAA UAG UGA]
  }.freeze

  def self.of_codon(codon)
    CODONS.invert.each { |key, val| return val.to_s if key.include?(codon.to_sym) }
  end

  def self.of_rna(strand)
    translation = []
    split_rna(strand)
      .each do |codon|
        break if CODONS[:STOP].include?(codon.to_sym)
        raise InvalidCodonError unless CODONS.values.flatten.include?(codon.to_sym)

        translation << of_codon(codon)
      end
    translation
  end

  def self.split_rna(rna)
    rna
      .chars
      .each_slice(3)
      .to_a
      .map(&:join)
  end
end
