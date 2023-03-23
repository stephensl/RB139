# Custom Set 

=begin

Create a custom set type.

Sometimes it is necessary to define a custom data structure of some type, like a set. In this exercise you will define your own set type. How it works internally doesn't matter, as long as it behaves like a set of unique elements that can be manipulated in several well defined ways.

In some languages, including Ruby and JavaScript, there is a built-in Set type. For this problem, you're expected to implement your own custom set type. Once you've reached a solution, feel free to play around with using the built-in implementation of Set.

For simplicity, you may assume that all elements of a set must be numbers.

---
---

P: 

- A set only allows for unique values 
- values can be stored in any order 
- all values must be numbers 

E: 
  - Instance methods for Custom set:

- constructor
  - takes array as argument 
  - contents of argument are elements of set 
  - if argument contains duplicate values, only one instance of value should be in set

- empty?
  - Custom set should be empty upon instantiation

- contains? method
  - takes integer argument 
  - returns true if set contains the item specified in argument

- subset? method
  - compares two CustomSet objects
  - returns true if argument set contains all elements in calling set
  - empty set is subset of non-empty set 
  - non-empty set is NOT subset of empty set. 

- disjoint? method
  - sets contain no commmon elements 
  - two empty sets return true
  - one empty set and one non-empty set return true

- eql?
  - both sets contain exact same elements 
  - order is unimportant
  - empty sets are equal to other empty sets
  - duplicates do not matter

- add method
    - adds argument to set
    - existing elements should not be added- or if added, should be removed

- intersection method
    - returns a new set that includes elements shared by two sets 
    - if no common elements, intersection is empty set 

- union method
      - merges two sets into new set
      - new set has unique elements

- difference method
      - new set that contains all elements of calling obj, that are NOT in argument set



D: 
  This solution will utilize Arrays as set data structure

Algo: (above for each instance method)

=end 

class CustomSet
  attr_accessor :data

  def initialize(array=[])
    @data = array.uniq 
  end 

  def empty?
    data.empty? 
  end 

  def contains?(num)
    data.include?(num)
  end 

  def subset?(other_set)
    data.all? { |datum| other_set.data.include?(datum) }
  end 

  def disjoint?(other_set)
    data.none? { |datum| other_set.data.include?(datum) }
  end 

  def eql?(other_set)
    return false unless data.length == other_set.data.length
    data.all? { |el| other_set.contains?(el) }
  end 

  def add(element)
    data << element unless data.include?(element)
    self
  end 

  def intersection(other_set)
    common_elements = []

    data.each do |item|
      common_elements << item if other_set.data.include?(item)
    end 

    CustomSet.new(common_elements)
  end 

  def union(other_set)
    combined = (data + other_set.data).uniq

    CustomSet.new(combined)
  end 

  def difference(other_set)
    diff = data - other_set.data 

    CustomSet.new(diff)
  end 

  def ==(other_set)
    eql?(other_set)
  end 
end 



# Tests 

require 'minitest/autorun'

class CustomSetTest < Minitest::Test
  def test_empty
    assert_equal true, CustomSet.new.empty?
  end

  def test_not_empty
    set = CustomSet.new([1])
    assert_equal false, set.empty?
  end

  def test_empty_does_not_contain
    set = CustomSet.new
    assert_equal false, set.contains?(1)
  end

  def test_does_contain
    set = CustomSet.new([1, 2, 3])
    assert_equal true, set.contains?(1)
  end

  def test_set_does_not_contain
    set = CustomSet.new([1, 2, 3])
    assert_equal false, set.contains?(4)
  end

  def test_subset_empty
    empty_set = CustomSet.new
    assert_equal true, empty_set.subset?(CustomSet.new)
  end

  def test_empty_is_subset_of_non_empty
    empty_set = CustomSet.new
    assert_equal true, empty_set.subset?(CustomSet.new([1]))
  end

  def test_non_empty_not_subset_of_empty
    set = CustomSet.new([1])
    assert_equal false, set.subset?(CustomSet.new)
  end

  def test_set_is_subset_of_same_set_of_elements
    set = CustomSet.new([1, 2, 3])
    assert_equal true, set.subset?(CustomSet.new([1, 2, 3]))
  end

  def test_set_is_subset_of_larger_set
    set = CustomSet.new([1, 2, 3])
    assert_equal true, set.subset?(CustomSet.new([4, 1, 2, 3]))
  end

  def test_not_subset_when_different_elements
    set = CustomSet.new([1, 2, 3])
    assert_equal false, set.subset?(CustomSet.new([4, 1, 3]))
  end

  def test_disjoint_empty_set
    empty_set = CustomSet.new
    assert_equal true, empty_set.disjoint?(CustomSet.new)
  end

  def test_disjoint_empty_and_non_empty
    empty_set = CustomSet.new
    assert_equal true, empty_set.disjoint?(CustomSet.new([1]))
  end

  def test_disjoint_non_empty_and_empty
    set = CustomSet.new([1])
    assert_equal true, set.disjoint?(CustomSet.new)
  end

  def test_disjoint_shared_element
    set = CustomSet.new([1, 2])
    assert_equal false, set.disjoint?(CustomSet.new([2, 3]))
  end

  def test_disjoint_no_shared_elements
    set = CustomSet.new([1, 2])
    assert_equal true, set.disjoint?(CustomSet.new([3, 4]))
  end

  def test_eql_empty
    empty_set = CustomSet.new
    assert_equal true, empty_set.eql?(CustomSet.new)
  end

  def test_eql_empty_and_non_empty
    empty_set = CustomSet.new
    assert_equal false, empty_set.eql?(CustomSet.new([1, 2, 3]))
  end

  def test_eql_non_empty_and_empty
    empty_set = CustomSet.new([1, 2, 3])
    assert_equal false, empty_set.eql?(CustomSet.new)
  end

  def test_eql_same_elements
    set = CustomSet.new([1, 2])
    assert_equal true, set.eql?(CustomSet.new([2, 1]))
  end

  def test_eql_different_elements
    set = CustomSet.new([1, 2, 3])
    assert_equal false, set.eql?(CustomSet.new([1, 2, 4]))
  end

  def test_eql_duplicate_elements_do_not_matter
    set = CustomSet.new([1, 2, 2, 1])
    assert_equal true, set.eql?(CustomSet.new([2, 1]))
  end

  def test_add_to_empty
    set = CustomSet.new
    set.add(3)
    assert_equal CustomSet.new([3]), set
  end

  def test_add_to_non_empty
    set = CustomSet.new([1, 2, 4]).add(3)
    expected = CustomSet.new([1, 2, 4, 3])
    assert_equal expected, set
  end

  def test_add_existing_element
    set = CustomSet.new([1, 2, 3]).add(3)
    expected = CustomSet.new([1, 2, 3])
    assert_equal expected, set
  end

  def test_intersection_empty
    set = CustomSet.new.intersection(CustomSet.new)
    expected = CustomSet.new
    assert_equal expected, set
  end

  def test_intersection_empty_and_non_empty
    set = CustomSet.new.intersection(CustomSet.new([3, 2, 5]))
    expected = CustomSet.new
    assert_equal expected, set
  end

  def test_intersection_non_empty_and_empty
    set = CustomSet.new([3, 2, 5]).intersection(CustomSet.new)
    expected = CustomSet.new
    assert_equal expected, set
  end

  def test_intersection_no_shared_elements
    first_set = CustomSet.new([1, 2, 3])
    second_set = CustomSet.new([4, 5, 6])
    actual = first_set.intersection(second_set)
    expected = CustomSet.new

    assert_equal expected, actual
  end

  def test_intersection_shared_elements
    first_set = CustomSet.new([1, 2, 3, 4])
    second_set = CustomSet.new([3, 2, 5])
    actual = first_set.intersection(second_set)
    expected = CustomSet.new([2, 3])

    assert_equal expected, actual
  end

  def test_difference_empty
    actual = CustomSet.new.difference(CustomSet.new)
    assert_equal CustomSet.new, actual
  end

  def test_difference_empty_and_non_empty
    actual = CustomSet.new.difference(CustomSet.new([3, 2, 5]))
    expected = CustomSet.new
    assert_equal expected, actual
  end

  def test_difference_non_empty_and_empty
    actual = CustomSet.new([1, 2, 3, 4]).difference(CustomSet.new)
    expected = CustomSet.new([1, 2, 3, 4])
    assert_equal expected, actual
  end

  def test_difference_non_empty_sets
    actual = CustomSet.new([3, 2, 1]).difference(CustomSet.new([2, 4]))
    expected = CustomSet.new([3, 1])
    assert_equal expected, actual
  end

  def test_union_empty
    actual = CustomSet.new.union(CustomSet.new)
    expected = CustomSet.new
    assert_equal expected, actual
  end

  def test_union_empty_and_non_empty
    actual = CustomSet.new.union(CustomSet.new([2]))
    expected = CustomSet.new([2])
    assert_equal expected, actual
  end

  def test_union_non_empty_and_empty
    actual = CustomSet.new([1, 3]).union(CustomSet.new)
    expected = CustomSet.new([1, 3])
    assert_equal expected, actual
  end

  def test_union_non_empty_sets
    actual = CustomSet.new([1, 3]).union(CustomSet.new([2, 3]))
    expected = CustomSet.new([1, 2, 3])
    assert_equal expected, actual
  end
end