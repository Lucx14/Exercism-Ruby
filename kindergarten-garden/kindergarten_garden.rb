class Garden
  attr_reader :pot_layout

  MAPPING = {
    "V": :violets,
    "R": :radishes,
    "C": :clover,
    "G": :grass
  }.freeze

  def initialize(pot_layout)
    @pot_layout = pot_layout
  end

  def alice
    arr = []
    pot_layout.split("\n").map do |a|
      row = []
      a.split('').each_slice(2) do |x|
        row << x.join
      end
      arr << row
    end
    breakdown_by_student = arr.transpose.map { |cc| cc.join.split('') }

    cl = breakdown_by_student.map do |stu|
      stu.map { |flower| MAPPING[flower.to_sym] }
    end

    # thats it!
    cl[0]
  end


  def bob
    arr = []
    pot_layout.split("\n").map do |a|
      row = []
      a.split('').each_slice(2) do |x|
        row << x.join
      end
      arr << row
    end
    breakdown_by_student = arr.transpose.map { |cc| cc.join.split('') }

    cl = breakdown_by_student.map do |stu|
      stu.map { |flower| MAPPING[flower.to_sym] }
    end

    # thats it!
    cl[1]

 
  end
end

   # p pot_layout.split("\n")
    # row_1 = pot_layout.split("\n")[0]
    # row_2 = pot_layout.split("\n")[1]

    # p row_1.split('')
    # p row_1.split('').each_slice(2) { |x| p x }
    # [:radishes, :clover, :grass, :grass]

# 24 pots on each row
# violets, Radish, Clover, Grass
# Alice, Bob, Charlie, David,
# Eve, Fred, Ginny, Harriet,
# Ileana, Joseph, Kincaid, and Larry.
# V: violets
# R: radishes
# C: clover
# G: grass
