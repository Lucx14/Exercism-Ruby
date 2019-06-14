class Phrase

  def initialize(sentence)
    @sentence = sentence
  end

  def word_count
    word_count = {}
    sentence.lstrip.downcase.split(/[^'\w]+/).each do |word|
      word.gsub!(/\A'|'\Z/, '')
      word_count.has_key?(word) ? word_count[word] += 1 : word_count[word] = 1
    end
    word_count
  end

  private

  attr_reader :sentence

end