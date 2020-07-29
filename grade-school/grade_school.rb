# frozen_string_literal: true

# Grade School
class School
  attr_reader :roster

  def initialize(roster = {})
    @roster = roster
  end

  def add(name, grade)
    roster[grade] ? roster[grade].push(name) : roster[grade] = [name]
  end

  def students(grade)
    roster.empty? ? [] : roster[grade].sort
  end

  def students_by_grade
    roster.sort.map { |k, v| { grade: k, students: v.sort } }
  end
end
