require 'minitest/autorun'

require_relative 'todo'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_size 
    assert_equal(3, @list.size)
  end 

  def test_first
    assert_equal(@todo1, @list.first)
  end 

  def test_shift_returns_first_item
    assert_equal(@todo1, @list.shift)
  end 

  def test_shift_removes_first_item
    @list.shift
    assert_equal([@todo2, @todo3], @list.to_a)
  end 

  def test_done?
    @list.done!
    assert(@list.done?)
  end 

  def test_type_error
    assert_raises(TypeError) { @list.add('string')}
  end 

  def test_shovel 
    @todo4 = Todo.new("shovel")

    @list << @todo4
    
    assert_equal([@todo1, @todo2, @todo3, @todo4], @list.to_a)
  end 

  def test_item_at
    assert_raises(IndexError) { @list.item_at(4) }
  end 
  
  def test_select 
    returned_arr = @tp.select { |todo| todo.title == "Buy Milk" }

    p returned_arr
  end 
end