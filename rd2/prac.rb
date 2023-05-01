require 'minitest/autorun'

class Testing < Minitest::Test
  def test_error
    @list = []

    assert_raises(NoExperienceError) { employee.hire }
  end 
end 