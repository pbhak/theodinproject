# frozen_string_literal: true

require_relative 'lib/tree'

a = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

a.build_tree
a.pretty_print
