class Phrase

  def initialize(sentence)
    @sentence = sentence
  end

  def word_count
    count = Hash.new(0)
    words.each { |word| count[word] += 1 }
    count
  end

  private

  attr_reader :sentence

  def words
    sentence.downcase.scan(/\b['\w]+\b/)
  end
end
