class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, i|
      if el.is_a?(Array)
        return el.hash
      else
        sum += el^i
      end
    end
    sum.hash
  end
end

class String
  def hash
    sum = 0
    self.chars.each_with_index do |letter, i|
      sum += letter.ord^i
    end
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash

    xored = []
    self.each do |key, value|
      xored << (key.hash ^ value.hash)
    end
    xored.sort.hash
  end
end
