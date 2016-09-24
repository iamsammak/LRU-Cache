require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self[key.hash] << key
    @count += 1
    resize! if @count > num_buckets
  end

  def include?(key)
    return true if self[key.hash].include?(key)
    false
  end

  def remove(key)
    self[key.hash].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    dummy = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    dummy.flatten.each do |el|
      @store[el % (num_buckets * 2)] << el
    end
  end
end
