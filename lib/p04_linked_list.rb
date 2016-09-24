class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail || @tail.prev == @head
  end

  def get(key)
    # current_link = @head.next
    # until current_link.next.nil?
    #   found_key = current_link.key
    #   return current_link.val if key == found_key
    #   current_link = current_link.next
    # end

    each { |link| return link.val if link.key == key }

    nil
  end

  def include?(key)
    # current_link = @head.next
    # until current_link.next.nil?
    #   found_key = current_link.key
    #   return true if key == found_key
    #   current_link = current_link.next
    # end
    #
    # false

    any? { |link| link.key == key }
  end

  def insert(key, val)
    # each { |link| return link.val = val if link.key == key }

    new_link = Link.new(key, val)

    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev = new_link

    new_link
  end

  def remove(key)
    # current_link = @head.next
    #
    # until current_link.next.nil?
    #
    #   found_key = current_link.key
    #   if key == found_key
    #     current_link.prev.next = current_link.next
    #     current_link.next.prev = current_link.prev
    #     break
    #   end
    #
    #   current_link = current_link.next
    # end

    each do |link|
      if link.key == key
        link.prev.next = link.next
        link.next.prev = link.prev
        link.next, link.prev = nil. nil
        return link.val
      end
    end

    nil
  end

  def each
    current_link = @head.next

    until current_link == @tail
      yield current_link
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
