# Robot Name 

# Write a program that manages robot factory settings.

# When robots come off the factory floor, they have no name. The first time you boot them up, a random name is generated, such as RX837 or BC811.

# Every once in a while, we need to reset a robot to its factory settings, which means that their name gets wiped. The next time you ask, it will respond with a new random name.

# The names must be random; they should not follow a predictable sequence. Random names means there is a risk of collisions. Your solution should not allow the use of the same name twice.

##


##
=begin
  
P: 

Create a program that sets random name when Robot is instantiated, or when factory reset takes place. 

Program should not allow same name to be used more than once. 

Rules: 

  - names should be two uppercase alphabetic letters followed by three digits.
  - no two names should be the same. 
  - Once a name is used, that sequence is not to be re-used. 

  Implicit: 
  
    - Robot class 
    - instance method to reset name 
    - check if name is taken, and if so, assign new.


E: provided

  - name method- returns string of robot's name 
  - reset method- resets factory functions, and new name is generated. 

D: 
  range of uppercase alphabetic letters
  range of three digit numbers 

  - array to store used names
  - string name values 

A: 

  - define Robot class 
  
  - constructor method
    - build name
    - check if already in use
      - assign if not
      - reassign and recheck if so  

  - reset method 
    - build name 
    - check if exists
    - assign or reassign

  - constant
    - USED_NAMES array containing all used names

=end 


class Robot 
  attr_reader :name 

  USED_NAMES = []

  def initialize
     @name = build_name
  end 

  def reset 
    USED_NAMES.delete(name)
    self.name = build_name
  end 

  private

  attr_writer :name 

  def build_name
    name = ''
    loop do 
      2.times { name << ('A'..'Z').to_a.sample}
      3.times { name << rand(9).to_s }
      break unless USED_NAMES.include?(name)
    end 
    USED_NAMES << name 
    name 
  end 

end 


require 'minitest/autorun'

class RobotTest < Minitest::Test
  DIFFERENT_ROBOT_NAME_SEED = 1234
  SAME_INITIAL_ROBOT_NAME_SEED = 1000

  NAME_REGEXP = /^[A-Z]{2}\d{3}$/

  def test_has_name
    assert_match NAME_REGEXP, Robot.new.name
  end

  def test_name_sticks
    robot = Robot.new
    robot.name
    assert_equal robot.name, robot.name
  end

  def test_different_robots_have_different_names
    Kernel.srand DIFFERENT_ROBOT_NAME_SEED
    refute_equal Robot.new.name, Robot.new.name
  end

  def test_reset_name
    Kernel.srand DIFFERENT_ROBOT_NAME_SEED
    robot = Robot.new
    name = robot.name
    robot.reset
    name2 = robot.name
    refute_equal name, name2
    assert_match NAME_REGEXP, name2
  end

  def test_different_name_when_chosen_name_is_taken
    Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
    name1 = Robot.new.name
    Kernel.srand SAME_INITIAL_ROBOT_NAME_SEED
    name2 = Robot.new.name
    refute_equal name1, name2
  end
end