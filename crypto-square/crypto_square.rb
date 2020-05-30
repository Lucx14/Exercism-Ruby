class Crypto
  def initialize(text)
    @text = normalize(text)
  end

  def ciphertext
    return text if text.length <= 1

    grid.transpose.map(&:join).join(' ')
  end

  private

  attr_reader :text

  def normalize(text)
    text.downcase.gsub(/[^a-z0-9]/, '')
  end

  def chunk_size
    Math.sqrt(text.length).ceil
  end

  def grid
    grid = text.chars.each_slice(chunk_size).to_a
    grid.last << ' ' while grid.last.size < chunk_size
    grid
  end
end
