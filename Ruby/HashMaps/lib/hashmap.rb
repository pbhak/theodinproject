# frozen_string_literal: true

require_relative 'linked_list'

# Ruby hashmap implementation
class HashMap
  attr_accessor :length

  HASH_MULTIPLIER = 31

  def initialize(load_factor = 0.75)
    @load_factor = load_factor
    @capacity = 16
    @length = 0
    @buckets = create_buckets
  end

  def calculate_growth # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    return unless @length >= (@capacity * @load_factor).round

    # Grow hashmap and repopulate entries
    @capacity *= 2
    @buckets_temp = @buckets.dup
    @buckets = create_buckets # Reset all buckets

    @buckets_temp.each do |bucket|
      index = 0
      until index > bucket.size - 1
        index += 1
        next if bucket[index].nil?

        # This is, in fact, a node
        key = bucket[index].key
        value = bucket[index].value

        set(key, value)
      end
    end

    @buckets = @buckets_temp
    @buckets_temp = nil
  end

  def create_buckets
    Array.new(@capacity) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0

    key.each_char do |char|
      hash_code = HashMap::HASH_MULTIPLIER * hash_code + char.ord
    end

    hash_code
  end

  def set(key, value)
    bucket_number = hash(key) % @capacity
    # Bucket contains key; remove node containing conflicting key
    original_size = @buckets[hash(key) % @capacity].size
    @buckets[bucket_number].remove_node_if_exists(key)
    # Remove an entry from the total length if a node was removed
    @length -= 1 if @buckets[hash(key) % @capacity].size == original_size - 1

    @buckets[bucket_number].add(key, value)
    @length += 1
    calculate_growth
  end

  def get(key)
    @buckets[hash(key) % @capacity].find(key)
  end

  def has?(key)
    @buckets[hash(key) % @capacity].contains?(key)
  end

  def remove(key)
    value = get(key)
    original_size = @buckets[hash(key) % @capacity].size
    @buckets[hash(key) % @capacity].remove_node_if_exists(key)

    @length -= 1 if @buckets[hash(key) % @capacity].size == original_size - 1
    value
  end

  def clear
    @buckets.each(&:clear!)
    @length = 0
  end

  def keys
    keys = []
    @buckets.each do |bucket|
      index = 0
      until index > bucket.size - 1
        keys << bucket.list[index].key unless bucket.list[index].nil?
        index += 1
      end
    end

    keys.sort
  end

  def values
    values = []
    @buckets.each do |bucket|
      index = 0
      until index > bucket.size - 1
        values << bucket.list[index].value unless bucket.list[index].nil?
        index += 1
      end
    end

    values.sort
  end

  def entries
    entries = []
    @buckets.each do |bucket|
      index = 0
      until index > bucket.size - 1
        entries << [bucket.list[index].key, bucket.list[index].value] unless bucket.list[index].nil?
        index += 1
      end
    end

    entries.sort
  end
end
