module Complement

  MAP = { "G" => "C", "C" => "G", "T" => "A", "A" => "U" }

  def self.of_dna(dna)
    dna.split('').map { |x| Complement::MAP[x]}.join('')
  end
end