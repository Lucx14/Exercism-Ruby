class Garden
  attr_reader :pot_layout, :students, :breakdown

  MAPPING = {
    "V": :violets,
    "R": :radishes,
    "C": :clover,
    "G": :grass
  }.freeze

  DEFAULT_STUDENTS = %w[Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry].freeze

  def initialize(pot_layout, students = DEFAULT_STUDENTS)
    @pot_layout = pot_layout
    @students = format_students(students)
    @breakdown = organise(pot_layout, format_students(students))
  end

  def method_missing method, *args, &block
    return super method, *args, &block unless students.include?(method)

    self.class.send(:define_method, method) do
      # p method
      # p breakdown
      # p "writing " + method.to_s.gsub(/^coding_/, '').to_s
      # p "hello I am here!!!"
      breakdown[method]
    end
    self.send method, *args, &block
  end


  # def alice
  #   # p students
  #   arr = []
  #   pot_layout.split("\n").map do |a|
  #     row = []
  #     a.split('').each_slice(2) do |x|
  #       row << x.join
  #     end
  #     arr << row
  #   end
  #   breakdown_by_student = arr.transpose.map { |cc| cc.join.split('') }

  #   cl = breakdown_by_student.map do |stu|
  #     stu.map { |flower| MAPPING[flower.to_sym] }
  #   end

  #   # thats it!
  #   cl[0]
  # end

  # def bob
  #   p students
  #   arr = []
  #   pot_layout.split("\n").map do |a|
  #     row = []
  #     a.split('').each_slice(2) do |x|
  #       row << x.join
  #     end
  #     arr << row
  #   end
  #   breakdown_by_student = arr.transpose.map { |cc| cc.join.split('') }

  #   cl = breakdown_by_student.map do |stu|
  #     stu.map { |flower| MAPPING[flower.to_sym] }
  #   end

  #   # thats it!
  #   breakdown = {}
  #   # p cl.last
  #   cl.each_with_index { |x, i| breakdown[students[i]] = x }
  #   # breakdown isa now the queryable object
  #   p breakdown
  #   cl[1]

  # end

  private

  def format_students(students)
    students.sort.map { |student| student.downcase.to_sym }
  end

  def organise(layout, students)
    # p students
    arr = []
    layout.split("\n").map do |a|
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
    breakdown = {}
    # p cl.last
    cl.each_with_index { |x, i| breakdown[students[i]] = x }
    # breakdown isa now the queryable object
    breakdown
    # cl[1]
  end

end
