module Enumerable
  def my_each_with_index
    index = 0
    self.my_each do |element|
      yield(element, index)
      index += 1
    end
    self
  end

  def my_select
    new_array = []
    self.my_each do |element|
      new_array << element if yield(element)
    end
    new_array
  end

  def my_all?
    self.my_each do |element|
      return false unless yield(element)
    end
    return true
  end

  def my_any?
    self.my_each do |element|
      return true if yield(element)
    end
    return false
  end

  def my_none?
    self.my_each do |element|
      return false if yield(element)
    end
    return true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      self.my_each do |element|
        count += 1 if yield(element)
      end
    elsif arg
      self.my_each do |element|
        count += 1 if element == arg
      end
    else
      count = self.length
    end
    count
  end

  def my_map
    result = []
    if block_given?
      self.my_each do |element|
        result << yield(element)
      end
      result
    else
      self.to_enum(:my_map)
    end
  end

  def my_inject(initial = nil)
    if initial.nil?
      index = 1;
      accumulator = self[0]

      while index < self.my_count()
        accumulator = yield(accumulator, self[index])
        index += 1
      end
    else
      accumulator = initial

      self.my_each do |element|
        accumulator = yield(accumulator, element)
      end
    end

    accumulator
  end
end 

class Array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end

    self
  end
end
