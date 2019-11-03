class Bob
  attr_reader :remark

  def self.hey(remark)
    Bob.new(remark).respond
  end

  def initialize(remark)
    @remark = remark
  end

  def respond
    case true
    when silence? then "Fine. Be that way!"
    when shouty_question? then "Calm down, I know what I'm doing!"
    when shouty? then "Whoa, chill out!"
    when question? then "Sure."
    else "Whatever."
    end
  end

  private

  def question?
    remark.strip[-1] == "?"
  end

  def shouty_question?
    question? && shouty?
  end

  def shouty?
    letters = extract_letters
    letters.upcase == letters && letters != ""
  end

  def silence?
    remark.strip == ""
  end

  def extract_letters
    remark.split('').reject{ |x| x.match(/[^a-zA-Z]/) }.join
  end
end
