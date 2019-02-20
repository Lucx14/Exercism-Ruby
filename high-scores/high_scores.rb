class HighScores

  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def personal_top
    scores.max(3)
  end

  def report
    latest == personal_best ? "#{print_latest}#{pb}" : "#{print_latest}#{print_diff}"
  end

  private

  def print_latest
    "Your latest score was #{latest}. "
  end

  def print_diff
    "That's #{difference} short of your personal best!"
  end

  def difference
    personal_best - latest
  end

  def pb
    "That's your personal best!"
  end
end
