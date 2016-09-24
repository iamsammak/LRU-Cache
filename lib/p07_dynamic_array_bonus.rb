class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i <= @count
      @store[i]
    else
      nil
    end
  end

  def []=(i, val)
    if i < @count
      @store[i] = val
    else
      until capacity == i + 1
        dummy = resize!
      end
      @count.times do |i|
        dummy[i] = @store[i]
      end
      @store = dummy
      @store[i] = val
      @count = @store.length
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    if capacity > @count
      @store[@count] = val
    else
      resize!
      @store[@count] = val
    end
    @count += 1
  end

  def unshift(val)

  end

  def pop
    return nil if @count == 0
    popped = self.last
    arr = DynamicArray.new(@count - 1)
    each do |el|
      arr.push(el) unless popped == el
    end
    @store = arr
    popped
  end

  def shift
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
    @count.times do |i|
      yield @store[i]
    end
    @store
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    dummy = StaticArray.new(@count + 1)
    dummy_count = 0
    (@count + 1).times do
      dummy[dummy_count] = nil
      dummy_count += 1
    end
    @count += 1
    dummy
  end
end
