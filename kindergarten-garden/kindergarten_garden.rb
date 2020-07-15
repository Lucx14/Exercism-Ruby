# frozen_string_literal: true

# Kindergarten-garden
class Garden
  DEFAULT_STUDENTS = %w[Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry].freeze
  MAPPING = {
    "V": :violets,
    "R": :radishes,
    "C": :clover,
    "G": :grass
  }.freeze

  private

  attr_reader :students, :breakdown

  def initialize(layout, students = DEFAULT_STUDENTS)
    @students = format_students(students)
    @breakdown = organise(group_plants_by_student(layout), format_students(students))
  end

  def method_missing(method, *args, &block)
    return super unless students.include?(method)

    self.class.send(:define_method, method) do
      breakdown[method]
    end
    send method, *args, &block
  end

  def respond_to_missing?(method, *)
    method if students.include?(method) || super
  end

  def format_students(students)
    students.sort.map { |student| student.downcase.to_sym }
  end

  def group_plants_by_student(layout)
    organised_rows = []
    layout.split("\n").map do |line|
      row = []
      line.split('').each_slice(2) do |pair|
        row << pair.join
      end
      organised_rows << row
    end
    organised_rows.transpose.map { |plants| plants.join.split('') }
  end

  def organise(layout, students)
    breakdown = {}
    layout
      .map { |student| student.map { |flower| MAPPING[flower.to_sym] } }
      .each_with_index { |x, i| breakdown[students[i]] = x }
    breakdown
  end
end
