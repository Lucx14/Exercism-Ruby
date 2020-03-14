class Robot

  attr_accessor :name

  def initialize(name = generate_name)
    @name = name
  end

  def self.forget
    true
  end

 

  def reset
    @name = generate_name
  end

  private

  def generate_name
    name = ""
    charset = Array('A'..'Z') + Array('A'..'Z')
    name << Array.new(2) { charset.sample }.join
    name << Array.new(3) { rand(0..9) }.join
    # p name
    name
  end



end
