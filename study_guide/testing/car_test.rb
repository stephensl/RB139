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

  def test_same_name
    car1 = Car.new 
    car2 = Car.new 

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal(car1, car2)
  end 

end 