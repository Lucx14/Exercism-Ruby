module Acronym

  def self.abbreviate(phrase)
    phrase.split(/\W+/).map { |x| x[0].upcase }.join('')
  end

end