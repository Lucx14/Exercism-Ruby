class Crypto
  attr_reader :text
  def initialize(text)
    @text = text
  end

  def ciphertext
    normalized_text = text.downcase.gsub(/[^a-z0-9]/, '')
    if normalized_text.length <= 1
      return normalized_text
    end
    # p normalized_text
    col = Math.sqrt(normalized_text.length).ceil
    # p col
    str = normalized_text.chars.each_slice(col).map(&:join).map{|x| x.ljust(col) }
    # p str
    row = str.length
    # p row
    encoded = ''
    while encoded.length < normalized_text.length
      str.each { |set| encoded << set.slice!(0) }
      # p encoded
    end
    xxx = encoded.gsub(/[^a-z]/, '')
    # p xxx
    diff = (col * row) - normalized_text.length
    # p diff
    # end
    # fin = xxx.strip.chars.each_slice(row).map
    # p fin
    # p fin.size
    final = []
    yy = []
    f = xxx.chars.each_slice(row).each_with_index do |x, i|
      # p x 
      # p i
      if i + 1 > col - diff
        if x.length == row
          yy << x.slice!(-1)
        end
        x << ' '
      end

      if x.length == row
        final << x.join('')
      else
        final << x.unshift(yy.pop).join('')
      end
    end

    # p final
    final.join(' ')

    

    # p fin.join(' ')
    # fin.join(' ')

    # "clu hlt io "
  end
end
