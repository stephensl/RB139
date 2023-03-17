require 'minitest/autorun'

require_relative 'cat'

class CatTest < Minitest::Test 
  def setup 
    @kitty = Cat.new('Kitty')
  end 

  def test_is_cat 
    assert_kind_of(Cat, @kitty)
  end 

  def test_name 
    assert_equal("Kitty", @kitty.name)
  end 

  def test_miaow 
    assert_equal("Kitty is miaowing.", @kitty.miaow)
  end 

  def test_raises_error 
    assert_raises(ArgumentError) { Cat.new }
  end 


end 