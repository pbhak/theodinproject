# frozen_string_literal: true

require_relative 'linked_list'

list = LinkedList.new

list.append('head')
list.append('1')
list.append('2')
list.append('3')
list.append('4')
list.append('tail')

list.insert_at(5, 5)

puts list
