class Tournament
 
  def self.tally(input)
    match_report = input.split("\n").map{|game| game.split(";")}
    new(match_report).generate_results_table
  end

  def generate_results_table
    calculate_results
    format_results
  end

  private

  TABLE_HEADER = "Team".ljust(31) + "| MP |  W |  D |  L |  P\n"

  attr_reader :match_report
  attr_accessor :results, :table

  def initialize(match_report, results = {}, table = "")
    @match_report = match_report
    @results = results
    @table = table << TABLE_HEADER
  end

  def calculate_results
    match_report.each do |game|
      convert_game_result(game)
    end
    @results = results.sort_by { |key, value| [-value[:P], key] }.to_h
  end

  def format_results
    results.each do |key, value|
      table << "#{key.ljust(31)}|  #{value[:MP]} |  #{value[:W]} |  #{value[:D]} |  #{value[:L]} |  #{value[:P]}\n"
    end
    table
  end

  def convert_game_result(game)
    game.take(2).each do |team|
      unless results.has_key?(team)
        results[team] = { MP: 0, W: 0, D: 0, L: 0, P: 0 }
      end
    end

    results[game[0]][:MP] += 1
    results[game[1]][:MP] += 1
    if game[2] == "win"
      results[game[0]][:W] += 1
      results[game[0]][:P] += 3
      results[game[1]][:L] += 1
    elsif game[2] == "loss"
      results[game[0]][:L] += 1
      results[game[1]][:W] += 1
      results[game[1]][:P] += 3
    elsif game[2] == "draw"
      results[game[0]][:D] += 1
      results[game[0]][:P] += 1
      results[game[1]][:D] += 1
      results[game[1]][:P] += 1
    end
  end
end
