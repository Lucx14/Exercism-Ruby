module FlattenArray

  # Flatten array
  def self.flatten(array)
    array.flatten.reject { |x| x.nil? }
  end
end