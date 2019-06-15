class Phrase

  def initialize(sentence)
    @sentence = sentence
  end

  def word_count
    word_count = Hash.new { |hash, key| hash[key] = 0 }
    string_to_array(sentence).each do |word|
      remove_quotes(word)
      word_count[word] += 1
    end
    word_count
  end

  private

  attr_reader :sentence

  def string_to_array(string)
    string.lstrip.downcase.split(/[^'\w]+/)
  end

  def remove_quotes(string)
    string.gsub!(/\A'|'\Z/, '')
  end
end