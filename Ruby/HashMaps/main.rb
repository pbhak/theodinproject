# frozen_string_literal: true

require_relative 'lib/hashmap'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

# Hashmap pretty much done. After the last set statement is called, the length jumps from 11 to 14
# instead of from 11 to 12. When disabling the growth function, normal function continues.
# After that's done, the hashmap is pretty much complete (aside from extra credit.)
