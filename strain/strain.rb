class Array

  def keep
    ary = []
    self.each{ |elem| ary << elem if yield(elem) }
    ary
  end

  def discard
    ary = []
    self.each{ |elem| ary << elem unless yield(elem) }
    ary
  end
end
