# frozen_string_literal: true

require_relative 'lib/hashset'


test = HashSet.new

test.set('apple')
test.set('banana')
test.set('carrot')
test.set('dog')
test.set('elephant')
test.set('frog')
test.set('grape')
test.set('hat')
test.set('ice cream')
test.set('jacket')
test.set('kite')
test.set('lion')
# Trigger hashmap growth (entries > 12)
test.set('moon')
a = [1, 2, 3]
