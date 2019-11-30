class PhoneNumber

  def self.clean(phone_number)
    num = phone_number.split('').select{ |x| x.match(/[0-9]/)}
    num.shift if num[0] == "1"

    if num.count == 10 && num[0].to_i > 1 && num[3].to_i > 1
      num.join
    else
      nil
    end
  end
end
