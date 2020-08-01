# frozen_string_literal: true

# Bowling
class Game
  def roll(pins)
    @current_roll = pins
    handle_input_errors
    handle_strikes_and_spares
    return if second_strike
    return if strike

    frame_scores << current_roll
    return unless frame_complete?

    end_frame
  end

  def score
    raise BowlingError unless game_over?

    frames.sum
  end

  private

  class BowlingError < StandardError; end
  FRAMES = 10
  STRIKE = 10

  attr_reader :frames, :current_roll
  attr_accessor :current_frame, :frame_scores, :spare_record, :strike_record

  def initialize
    @frames = []
    @current_frame = 1
    @frame_scores = []
    @spare_record = []
    @strike_record = []
  end

  def handle_input_errors
    raise BowlingError if game_over?
    raise BowlingError unless valid_pins?
  end

  def handle_first_strike
    strike_record << current_roll
    next_frame unless final_frame
  end

  def next_frame
    self.current_frame += 1
  end

  def valid_pins?
    current_roll.between?(0, STRIKE) &&
      frame_scores.sum + current_roll <= STRIKE &&
      !invalid_strike_chain?
  end

  def invalid_strike_chain?
    !strike_record.empty? &&
      strike_record.last != STRIKE &&
      current_roll + strike_record.last > STRIKE
  end

  def final_frame
    current_frame == FRAMES
  end

  def handle_strikes_and_spares
    complete_strike unless strike_record.empty?
    complete_spare unless spare_record.empty?
    handle_first_strike if strike_on_first_roll?
  end

  def second_strike
    !strike_record.empty? &&
      (current_roll == STRIKE || final_frame)
  end

  def strike_on_first_roll?
    frame_scores.empty? &&
      current_roll == STRIKE &&
      strike_record.empty?
  end

  def frame_complete?
    frame_scores.length == 2 || strike_record.length == 3
  end

  def strike
    current_roll == STRIKE
  end

  def end_frame
    frame_scores.sum < 10 ? frames << frame_scores.sum : spare_record << frame_scores.sum
    next_frame
    reset_frame_scores
  end

  def complete_spare
    spare_record << current_roll
    frames << spare_record.sum
    spare_record.clear
  end

  def complete_strike
    strike_record << current_roll
    return unless frame_complete?

    frames << strike_record.sum
    strike_record.shift
    strike_record.clear unless strike_record.include?(STRIKE)
  end

  def reset_frame_scores
    frame_scores.clear
  end

  def game_over?
    frames.length == FRAMES
  end
end
