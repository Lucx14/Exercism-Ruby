class Phrase

  attr_reader :sentence

  def initialize(sentence)
    @sentence = sentence
  end

  def word_count
    {"word"=>1}
  end

end