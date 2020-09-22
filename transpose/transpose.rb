# frozen_string_literal: true

require 'pry'

# Transpose
module Transpose

  def self.transpose(input)
    # return '' if input.empty?

    rows = input.split("\n")
    max = rows.map(&:length).max

    sanitized_phrases = rows.map { |row| row.ljust(max) }.map(&:chars)
    p sanitized_phrases.transpose.map{ |cc| cc.join.rstrip}.join("\n").strip

    # p sanitized_phrases.map { |phrase| phrase.split('')}.transpose.map(&:join).join("\n").strip

  #  p pp
  #   phrases2 = phrases.map { |el| el.ljust(pp)}


  #   res = []

  #   (0..pp).each do |i|
  #     yy = []
  #     phrases2.each do |el|
  #       yy << el[i]
  #     end
  #     p yy
  #     res << yy
  #   end
  #   p res
  #   phrases2.length.times do
  #     res.each { |section| section.pop if section.last.nil? }
  #   end
  #   p res
  #   qq = res.map { |section| section.map { |el| el.nil? ? ' ' : el } }

  #   p qq.map(&:join).reject(&:empty?).join("\n")
  end
end
