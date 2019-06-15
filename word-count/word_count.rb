class Phrase

  def initialize(sentence)
    @sentence = sentence
  end

  def word_count
    count = Hash.new(0)
    words.each do |word|
      remove_quotes(word)
      count[word] += 1
    end
    count
  end

  private

  attr_reader :sentence

  def words
    sentence.lstrip.downcase.split(/[^'\w]+/)
  end

  def remove_quotes(string)
    string.gsub!(/\A'|'\Z/, '')
  end
end
