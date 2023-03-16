require 'minitest/autorun'

require_relative 'car'

class CarTest < Minitest::Test 
  def setup 
    @car = Car.new
  end 

  def test_wheels 
    assert_equal(4, @car.wheels)
  end 

  def test_car_exists
    assert(@car)
  end 


end 