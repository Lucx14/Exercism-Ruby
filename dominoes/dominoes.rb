# frozen_string_literal: true

# Dominoes
class Dominoes
  def self.chain?(dominoes)
    if dominoes.length == 1
      return false if dominoes[0][0] != dominoes[0][1]
    end

    all_possible_layouts = dominoes.permutation.to_a

    result = all_possible_layouts.map do |possibility|
      original_dominoes = possibility.each_with_index.map { |domino, i| [i + 1, domino] }
      reversed_dominoes = possibility.map(&:reverse).each_with_index.map { |domino, i| [i + 1, domino] }
      domino_shapes = original_dominoes + reversed_dominoes

      domino_shapes
        .combination(dominoes.length)
        .to_a
        .select { |combo| combo.map(&:first).uniq.length == dominoes.length }
        .map { |group| group.map(&:last) }
        .find do |combination|
          result = true
          (0..dominoes.length - 2).each do |i|
            result = false if combination[i].last != combination[i + 1].first
            result = false if combination.flatten.first != combination.flatten.last
          end
          combination if result
        end
    end

    result.compact.first
  end
end
