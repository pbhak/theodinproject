# frozen_string_literal: true

require_relative 'linked_list'

# Ruby hashmap implementation
class HashSet
  attr_accessor :length, :buckets

  HASH_MULTIPLIER = 31

  def initialize(load_factor = 0.75)
    @load_factor = load_factor
    @capacity = 16
    @length = 0
    @buckets = create_buckets
  end

  def calculate_growth # rubocop:disable Metrics/MethodLength
    return unless @length > (@capacity * @load_factor).round

    # Grow hashmap and repopulate entries
    @capacity *= 2
    @buckets_temp = @buckets.dup
    @buckets = create_buckets # Reset all buckets

    @buckets_temp.each do |bucket|
      index = 0
      until index > bucket.size - 1
        next if bucket[index].nil?

        # This is, in fact, a node
        key = bucket[index].key

        set(key)
        @length -= 1 # Running set() increments @length, which we don't want since no entries are changing
        index += 1
      end
    end

    @buckets_temp = nil
  end

  def create_buckets
    Array.new(@capacity) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0

    key.each_char do |char|
      hash_code = HashSet::HASH_MULTIPLIER * hash_code + char.ord
    end

    hash_code
  end

  def set(key)
    bucket_number = hash(key) % @capacity
    raise IndexError if bucket_number.negative? || bucket_number >= @buckets.length

    # Bucket contains key; remove node containing conflicting key
    original_size = @buckets[bucket_number].size
    @buckets[bucket_number].remove_node_if_exists(key)
    # Remove an entry from the total length if a node was removed
    @length -= 1 if @buckets[bucket_number].size == original_size - 1

    @buckets[bucket_number].add(key)
    @length += 1
    calculate_growth

    key
  end

  def has?(key)
    bucket_number = hash(key) % @capacity
    raise IndexError if bucket_number.negative? || bucket_number >= @buckets.length

    @buckets[bucket_number].contains?(key)
  end

  def remove(key)
    bucket_number = hash(key) % @capacity
    raise IndexError if bucket_number.negative? || bucket_number >= @buckets.length

    original_size = @buckets[bucket_number].size
    @buckets[bucket_number].remove_node_if_exists(key)

    @length -= 1 if @buckets[bucket_number].size == original_size - 1
    true
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

    keys
  end
end
