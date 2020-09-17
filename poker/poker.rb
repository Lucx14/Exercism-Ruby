# frozen_string_literal: true

# Poker
class Poker
  attr_reader :hands
  def initialize(list_of_hands)
    @hands = list_of_hands.map { |hand| Hand.new(hand) }
  end

  def best_hand
    best = hands.max
    hands.select { |h| h == best }.map(&:to_s)
  end
end

# Hand
class Hand
  include Comparable
  RANKS = %i[high_card one_pair two_pair three_of_a_kind straight flush full_house four_of_a_kind straight_flush].freeze

  attr_reader :cards, :rank, :data

  def initialize(cards)
    @cards = cards.map { |card| Card.new(card) }
    @rank = determine_hand[:hand_rank]
    @data = determine_hand[:data]
  end

  def <=>(other)
    return rank_position <=> other.rank_position unless rank == other.rank

    case rank
    when :four_of_a_kind
      unless data[:quadruplet].first.score == other.data[:quadruplet].first.score
        return data[:quadruplet].first.score <=> other.data[:quadruplet].first.score
      end

      data[:kickers].first.score <=> other.data[:kickers].first.score
    when :full_house
      unless data[:triplet].first.score == other.data[:triplet].first.score
        return data[:triplet].first.score <=> other.data[:triplet].first.score
      end
      unless data[:pair].first.score == other.data[:pair].first.score
        return data[:pair].first.score <=> other.data[:pair].first.score
      end

      0
    when :three_of_a_kind
      unless data[:triplet].first.score == other.data[:triplet].first.score
        return data[:triplet].first.score <=> other.data[:triplet].first.score
      end

      data[:kickers].first.score <=> other.data[:kickers].first.score
    when :two_pair
      unless data[:pairs].first.first.score == other.data[:pairs].first.first.score
        return data[:pairs].first.first.score <=> other.data[:pairs].first.first.score
      end
      unless data[:pairs].last.first.score == other.data[:pairs].last.first.score
        return data[:pairs].last.first.score <=> other.data[:pairs].last.first.score
      end

      data[:kickers].first.score <=> other.data[:kickers].first.score
    when :one_pair
      unless data[:pair].first.score == other.data[:pair].first.score
        return data[:pair].first.score <=> other.data[:pair].first.score
      end

      data[:kickers].first.score <=> other.data[:kickers].first.score
    else
      data[:ranks].map(&:score).zip(other.data[:ranks].map(&:score)) do |a, b|
        return a <=> b unless a == b
      end
      0
    end
  end

  def rank_position
    RANKS.index(rank)
  end

  def suits_count
    cards.each_with_object(Hash.new(0)) { |card, hash| hash[card.suit] += 1 }
  end

  def rank_count
    cards.each_with_object(Hash.new(0)) { |card, hash| hash[card.rank] += 1 }
  end

  def determine_hand
    if straight_flush?
      { hand_rank: :straight_flush, data: { ranks: cards_sorted_by_points } }
    elsif four_of_a_kind?
      { hand_rank: :four_of_a_kind, data: { quadruplet: matched_ranks(4), kickers: hand_kickers } }
    elsif full_house?
      { hand_rank: :full_house, data: { triplet: matched_ranks(3), pair: matched_ranks(2) } }
    elsif flush?
      { hand_rank: :flush, data: { ranks: cards_sorted_by_points } }
    elsif straight?
      { hand_rank: :straight, data: { ranks: cards_sorted_by_points } }
    elsif three_of_a_kind?
      { hand_rank: :three_of_a_kind, data: { triplet: matched_ranks(3), kickers: hand_kickers } }
    elsif two_pair?
      { hand_rank: :two_pair, data: { pairs: extract_2_pairs, kickers: hand_kickers } }
    elsif one_pair?
      { hand_rank: :one_pair, data: { pair: matched_ranks(2), kickers: hand_kickers } }
    else
      { hand_rank: :high_card, data: { ranks: cards_sorted_by_points } }
    end
  end

  def consecutive_numbers?(arr)
    res = []
    high_card = arr.sort.reverse.first
    res << high_card
    4.times { res << (high_card -= 1) }
    res == arr.sort.reverse
  end

  def cards_sorted_by_points
    return cards.sort_by(&:score).take(4).reverse if cards.map(&:rank).sort == %w[2 3 4 5 A]

    cards.sort_by(&:score).reverse
  end

  def straight_flush?
    rank_count.keys.length == 5 && suits_count.keys.length == 1 && consecutive_numbers?(cards.map(&:score))
  end

  def four_of_a_kind?
    rank_count.values.include?(4) && suits_count.keys.length == 4
  end

  def full_house?
    rank_count.values.include?(3) && rank_count.values.include?(2)
  end

  def flush?
    suits_count.values.include?(5)
  end

  def straight?
    return true if cards.map(&:rank).sort == %w[2 3 4 5 A]

    consecutive_numbers?(cards.map(&:score))
  end

  def three_of_a_kind?
    rank_count.keys.length == 3 && rank_count.values.include?(3) && rank_count.values.include?(1)
  end

  def two_pair?
    rank_count.keys.length == 3 && rank_count.values.include?(2) && rank_count.values.include?(1)
  end

  def one_pair?
    rank_count.keys.length == 4 && rank_count.values.include?(2) && rank_count.values.include?(1)
  end

  def high_card?
    rank_count.keys.length == 5 && !consecutive_numbers?(cards.map(&:score)) && suits_count.keys.length > 1
  end

  def hand_kickers
    kicker_ranks = rank_count.map { |k, v| k if v == 1 }.compact
    cards.map { |card| card if kicker_ranks.include?(card.rank) }.compact.sort_by(&:score).reverse
  end

  def matched_ranks(frequency)
    rank = rank_count.map { |k, v| k if v == frequency }.compact[0]
    cards.map { |card| card if card.rank == rank }.compact
  end

  def extract_2_pairs
    ranks = rank_count.map { |k, v| k if v == 2 }.compact
    cards.map { |card| card if ranks.include?(card.rank) }.compact.sort_by(&:score).each_slice(2).to_a.reverse
  end

  def to_s
    cards.map(&:string_representation)
  end
end

# Card
class Card
  include Comparable
  CARD_POINTS = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }.freeze
  attr_reader :rank, :suit, :score, :string_representation
  def initialize(card)
    @string_representation = card
    @suit = evaluate_suit(card)
    @rank = card.slice(0...-1)
    @score = CARD_POINTS[rank]
  end

  def evaluate_suit(card)
    case card.split('').last
    when 'S' then :spades
    when 'H' then :hearts
    when 'D' then :diamonds
    when 'C' then :clubs
    else raise ArgumentError, 'invalid card!'
    end
  end

  def <=>(other)
    score <=> other.score
  end
end
