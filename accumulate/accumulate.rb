class Array
  def accumulate
    return to_enum(:each) unless block_given?
    ary = []
    
    self.each do |elem|
      ary << yield(elem)
    end
    
    ary
  end
end