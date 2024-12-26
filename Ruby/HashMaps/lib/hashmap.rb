# frozen_string_literal: true

# Ruby hashmap implementation
class HashMap
  CAPACITY = 16

  def initialize(load_factor)
    @load_factor = load_factor
    @buckets = Array.new(@capacity)
    @number_of_entries = 0
  end

  def hash(key)
    hash_code = 0
    multiplier = 31

    key.each_char do |char|
      hash_code = multiplier * hash_code + char.ord
    end

    hash_code
  end

  def set(key, value) 
    bucket_number = hash(key) % @capacity

    @buckets[bucket_number] = value
    @number_of_entries += 1
  end

  def get(key)
    @buckets[hash(key) % @capacity]
  end

  def has?(key)
    !@buckets[hash(key) % @capacity].nil?
  end

  def remove(key)
    if has?(key)
      deleted_entry = @buckets[hash(key) % @capacity]
      @buckets[hash(key) % @capacity] = nil
      deleted_entry
    end

    nil
  end

  def length
    length = 0
    @buckets.each do |bucket|
      length += 1 unless bucket.nil?
    end
  end

  def clear
    buckets.each_index do |bucket_index|
      @buckets[bucket_index] = nil unless @buckets[bucket_index].nil?
    end
  end

  def keys; end # ???

  def values
    values = []
    buckets.each do |bucket|
      values << bucket unless bucket.nil?
    end

    values
  end

  def entries; end # ???
end
