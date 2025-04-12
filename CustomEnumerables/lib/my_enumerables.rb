# rubocop:disable Style/For
# a
module Enumerable
  def my_each_with_index
    index = 0
    for x in self do
      yield(x, index)
      index += 1
    end
  end

  def my_select
    final = []
    for x in self do
      final << x if yield x
    end
    final
  end

  def my_all?
    results = []
    for x in self do
      if yield x
        results << true
      else
        results << false
      end
    end

    return false if results.include? false

    true
  end

  def my_any?
    results = []
    for x in self do
      if yield x
        results << true
      else
        results << false
      end
    end

    return true if results.include? true

    false
  end

  def my_none?
    results = []
    for x in self do
      if yield x
        results << true
      else
        results << false
      end
    end

    return false if results.include? true

    true
  end

  def my_count(obj = nil)
    return length if obj.nil? && !block_given?

    unless block_given?
      count = 0
      for x in self do
        count += 1 if x == obj
      end

      return count
    end

    count = 0
    for x in self do
      count += 1 if yield x
    end

    count
  end

  def my_map
    new_array = []

    for x in self do
      new_array << yield(x)
    end

    new_array
  end

  def my_inject(accumulator)
    for x in self do
      accumulator = yield(accumulator, x)
    end
    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
#
class Array
  def my_each
    for x in self do
      yield x
    end
  end
end
# rubocop:enable Style/For
