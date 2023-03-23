# Simple Linked List 

=begin
  
Write a simple linked list implementation. The linked list is a fundamental data structure in computer science, often used in the implementation of other data structures.

The simplest kind of linked list is a singly linked list. Each element in the list contains data and a "next" field pointing to the next element in the list of elements. This variant of linked lists is often used to represent sequences or push-down stacks (also called a LIFO stack; Last In, First Out).

Let's create a singly linked list whose elements may contain a range of data such as the numbers 1-10. Provide methods to reverse the linked list and convert a linked list to and from an array.
  

---
---

p: 

Create a simple linked list where each element in the list contains data and a "next" field that points to the next element in the list of elements. 

Create a singly linked list whose elements may contain a range of data, such as numbers 1-10. 

Methods should be provided to reverse the list and to convert it to and from an array.

Rules: (from test cases and description)
  - Singly linked list- each element in the list does not need to have info about any other element in the list except for the `next` element. 
  - Each element in the list contains data (a value) and a `next` field that points to the next element in the list of elements
  - The elements of the list may contain any data values
  - Method to reverse linked list, and method to convert to and from array 
  - helper methods


E: (test cases provided)
 
  - Element class 
    - constructor expects at least one argument.
      - first argument is data to be stored in the newly created element
      - second optional argument is another Element object that will be the next element after the newly created element. 
    - method that returns the data value of Element
    - method that returns a boolean indicating whether current element is tail of list
      - tail element does not have another object stored in next field.
    - method that returns the next element in the linked list. 
      - if current element is tail, return nil

  - SimpleLinkedList class
        - class method that creates a new SimpleLinkedList instance from a given array argument
        - class method that converts SimpleLinkedList to array
          - The datum from each link in list should be an element in the returned array 
        - method to adds its argument to the list 
        - method that removes the head of the list (most recently added element)
        - method that returns element at the head of the list
        - method returns the size of the list 
        - method returns boolean indicating if empty or not
        - method returns data value of the head element
        - method that returns the list but in reverse order


D: 
    Data in each Element object may be any type.

A: 

- Element Class

  - constructor 
        - save first argument as new Element's datum 
        - save second argument as the next Element 
          - if second arg omitted use default value of nil 
  
  - datum method
    - return Element value 

  - tail method
    - return true if does not have next element 

  - next method
    - return next element object


SimpleLinkedList class 

  - constructor 
    - set object's head instance var to initial value indicating empty list
      - no constructor method necessary as @head will have nil value by default

  - class method- convert array to linked list 
    - if array argument omitted, use empty array 
    - create new instance of SimpleLinkedList
    - for each element in the array, push the elements value to the new linked list
    - return the new linked list

  - convert linked list to array 
      - create an empty array for result 
      - set current element to head Element 
      - while current element is valid Element
        - append datum value of current element to result array 
        - reassign the current element variable to next Element 
      - return result array 

  - push method
      - create new Element object with the value and next element passed to push as its two args
      - save new element object to lsit as its new head element 
  
  - pop method
      - save current head element temporarily
      - set linked lists head element ot value of the old head elements next instance var 
      - return the datum value of the old head element 
=end

class Element
  attr_reader :datum, :next

  def initialize(datum, next_element = nil)
    @datum = datum
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def size
    size = 0
    current_elem = @head
    while (current_elem)
      size += 1
      current_elem = current_elem.next
    end
    size
  end

  def empty?
    @head.nil?
  end

  def push(datum)
    element = Element.new(datum, @head)
    @head = element
  end

  def peek
    @head.datum if @head
  end

  def pop
    datum = peek
    new_head = @head.next
    @head = new_head
    datum
  end

  def self.from_a(array)
    array = [] if array.nil?

    list = SimpleLinkedList.new
    array.reverse_each { |datum| list.push(datum) }
    list
  end

  def to_a
    array = []
    current_elem = head
    while !current_elem.nil?
      array.push(current_elem.datum)
      current_elem = current_elem.next
    end
    array
  end

  def reverse
    list = SimpleLinkedList.new
    current_elem = head
    while !current_elem.nil?
      list.push(current_elem.datum)
      current_elem = current_elem.next
    end
    list
  end
end



# Test cases 

require 'minitest/autorun'

class LinkedListTest < Minitest::Test
  def test_element_datum
    element = Element.new(1)
    assert_equal 1, element.datum
  end

  def test_element_tail
    element = Element.new(1)
    assert element.tail?
  end

  def test_element_next_default
    element = Element.new(1)
    assert_nil element.next
  end

  def test_element_next_initialization
    element1 = Element.new(1)
    element2 = Element.new(2, element1)
    assert_equal element1, element2.next
  end

  def test_empty_list_size
    list = SimpleLinkedList.new
    assert_equal 0, list.size
  end

  def test_empty_list_empty
    list = SimpleLinkedList.new
    assert list.empty?
  end

  def test_pushing_element_on_list
    list = SimpleLinkedList.new
    list.push(1)
    assert_equal 1, list.size
  end

  def test_empty_list_1_element
    list = SimpleLinkedList.new
    list.push(1)
    refute list.empty?
  end

  def test_peeking_at_list
    list = SimpleLinkedList.new
    list.push(1)
    assert_equal 1, list.size
    assert_equal 1, list.peek
  end

  def test_peeking_at_empty_list
    list = SimpleLinkedList.new
    assert_nil list.peek
  end

  def test_access_head_element
    list = SimpleLinkedList.new
    list.push(1)
    assert_instance_of Element, list.head
    assert_equal 1, list.head.datum
    assert list.head.tail?
  end

  def test_items_are_stacked
    list = SimpleLinkedList.new
    list.push(1)
    list.push(2)
    assert_equal 2, list.size
    assert_equal 2, list.head.datum
    assert_equal 1, list.head.next.datum
  end

  def test_push_10_items
    list = SimpleLinkedList.new
    (1..10).each do |datum|
      list.push(datum)
    end
    assert_equal 10, list.size
    assert_equal 10, list.peek
  end

  def test_pop_1_item
    list = SimpleLinkedList.new
    list.push(1)
    assert_equal 1, list.pop
    assert_equal 0, list.size
  end

  def test_popping_frenzy
    list = SimpleLinkedList.new
    (1..10).each do |datum|
      list.push(datum)
    end
    6.times { list.pop }
    assert_equal 4, list.size
    assert_equal 4, list.peek
  end

  def test_from_a_empty_array
    list = SimpleLinkedList.from_a([])
    assert_equal 0, list.size
    assert_nil list.peek
  end

  def test_from_a_nil
    list = SimpleLinkedList.from_a(nil)
    assert_equal 0, list.size
    assert_nil list.peek
  end

  def test_from_a_2_element_array
    list = SimpleLinkedList.from_a([1, 2])
    assert_equal 2, list.size
    assert_equal 1, list.peek
    assert_equal 2, list.head.next.datum
  end

  def test_from_a_10_items
    list = SimpleLinkedList.from_a((1..10).to_a)
    assert_equal 10, list.size
    assert_equal 1, list.peek
    assert_equal 10, list.head.next.next.next.next.next.next.next.next.next.datum
  end

  def test_to_a_empty_list
    list = SimpleLinkedList.new
    assert_equal [], list.to_a
  end

  def test_to_a_of_1_element_list
    list = SimpleLinkedList.from_a([1])
    assert_equal [1], list.to_a
    assert_equal 1, list.size
    assert_equal 1, list.peek
  end

  def test_to_a_of_2_element_list
    list = SimpleLinkedList.from_a([1, 2])
    assert_equal [1, 2], list.to_a
    assert_equal 2, list.size
    assert_equal 1, list.head.datum
    assert_equal 2, list.head.next.datum
  end

  def test_reverse_2_element_list
    list = SimpleLinkedList.from_a([1, 2])
    # list_r and list need not be the same object
    list_r = list.reverse

    assert_equal 2, list_r.peek
    assert_equal 1, list_r.head.next.datum
    assert list_r.head.next.tail?
  end

  def test_reverse_10_element_list
    data = (1..10).to_a
    list = SimpleLinkedList.from_a(data)
    assert_equal data.reverse, list.reverse.to_a
  end

  def test_roundtrip_10_element_array
    data = (1..10).to_a
    assert_equal data, SimpleLinkedList.from_a(data).to_a
  end
end
