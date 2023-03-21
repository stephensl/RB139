# Clock 

=begin
  
Create a clock that is independent of date.

You should be able to add minutes to and subtract minutes from the time represented by a given Clock object. Note that you should not mutate Clock objects when adding and subtracting minutes -- create a new Clock object.

Two clock objects that represent the same time should be equal to each other.

You may not use any built-in date or time functionality; just use arithmetic operations.


#
#
#
#
---


P: 

Create a clock object with functionality to: 
  - add minutes (returns new clock object)
  - subtract minutes (returns new clock object)
  - two clock objects representing the same time should be equal
  - cannot use built in time/date functionality. 


Implicit: 

  - clock should be in format 00:00 (represents midnight)
  - class is called Clock
  
  Class Methods:
    - ::at method 
      - accepts one argument, and one optional argument with default to 0 (hour, mins)
      - returns new instance of clock
    - + method 
      - adds minutes
    - - method
      - subtracts minutes 
    - == method
      - returns true if time displayed is the same 
    - to_s
      - returns current time as string

E: above

D: integers, string return value for showing time

A: 

- Define Clock class

- Constructor method
  - one required argument (hours) and one default optional set to 0 (mins)
    - instance variable @time set to xx:xx format

- ::at method 
  - class method
  - two parameters, hours, mins = 0 
  - returns new clock object with @time set to arguments specified

- #+ method 
  - takes one argument, minutes
  - adds minutes to current time and returns new clock object 

- #- method
  - takes one argument, minutes
  - subtracts minutes supplied by arg, returns new clock object

- #== method 
  - compares the time of two clock objects
    - returns true if same time, else false

- #to_s method
  - returns string representation of current time
  - format "05:19"


=end 

# class Clock 
#   attr_reader :current_time

#   def initialize(hours, minutes=0)
#     @current_hours = hours 
#     @current_minutes = minutes 
#     @current_time = format_time(hours, minutes)
#   end 

#   def self.at(hours, minutes=0)
#     Clock.new(hours, minutes)
#   end 

#   def format_time(hours, minutes=0)
#     minutes = minutes.digits.size < 2 ? "0#{minutes}" : "%02d" % minutes.to_s
#     hours = hours.digits.size < 2 ? "0#{hours}" : "%02d" % hours.to_s 

#     "#{hours}:#{minutes}"
#   end 

#   def +(minutes)
#     hours_to_add = 0
#     total_mins = @current_minutes + minutes 

#     while total_mins >= 60 
#       total_mins -= 60 
#       hours_to_add += 1
#     end 

#     @current_hours += hours_to_add
#     @current_minutes = total_mins 

#     Clock.at(@current_hours, @current_minutes)
#   end 

#   def to_s 
#     @current_time 
#   end

#   def ==(other)
#     current_time == other.current_time
#   end 

# end 



#
#
#
#
#
#
#
#

# With LS solution walkthrough 

class Clock 
  attr_reader :hour, :minute 

  ONE_DAY = 24 * 60                           # 1440 minutes in one day 

  def initialize(hour, minute)
    @hour = hour 
    @minute = minute 
  end 

  def self.at(hour, minute=0)
    new(hour, minute)
  end 

  def +(add_minutes)
    minutes_since_midnight = compute_minutes_since_midnight + add_minutes 
    while minutes_since_midnight >= ONE_DAY 
      minutes_since_midnight -= ONE_DAY 
    end 
    
    compute_time_from(minutes_since_midnight)
  end 

  def -(sub_minutes)
    minutes_since_midnight = compute_minutes_since_midnight - sub_minutes
    while minutes_since_midnight < 0 
      minutes_since_midnight += ONE_DAY 
    end 

    compute_time_from(minutes_since_midnight)
  end 

  def ==(other_time)
    hour == other_time.hour && minute == other_time.minute
  end

  def to_s
    format('%02d:%02d', hour, minute);
  end

  private 

  def compute_minutes_since_midnight 
    total_minutes = 60 * hour + minute 
    total_minutes % ONE_DAY 
  end 

  def compute_time_from(minutes_since_midnight)
    hours, minutes = minutes_since_midnight.divmod(60)
    hours %= 24 
    self.class.new(hours, minutes)
  end 
end 







require 'minitest/autorun'


class ClockTest < Minitest::Test
  def test_on_the_hour
    assert_equal '08:00', Clock.at(8).to_s
    assert_equal '09:00', Clock.at(9).to_s
  end

  def test_past_the_hour
    assert_equal '11:09', Clock.at(11, 9).to_s
  end

  def test_add_a_few_minutes
    clock = Clock.at(10) + 3
    assert_equal '10:03', clock.to_s
  end

  def test_adding_does_not_mutate
    old_clock = Clock.at(10)
    new_clock = old_clock + 3
    refute_same new_clock, old_clock
  end

  def test_subtract_fifty_minutes
    clock = Clock.at(0) - 50
    assert_equal '23:10', clock.to_s
  end

  def test_subtracting_does_not_mutate
    old_clock = Clock.at(10)
    new_clock = old_clock - 50
    refute_same new_clock, old_clock
  end

  def test_add_over_an_hour
    clock = Clock.at(10) + 61
    assert_equal '11:01', clock.to_s
  end

  def test_wrap_around_at_midnight
    clock = Clock.at(23, 30) + 60
    assert_equal '00:30', clock.to_s
  end

  def test_add_more_than_a_day
    clock = Clock.at(10) + 3061
    assert_equal '13:01', clock.to_s
  end

  def test_subtract_a_few_minutes
    clock = Clock.at(10, 30) - 5
    assert_equal '10:25', clock.to_s
  end

  def test_subtract_minutes
    clock = Clock.at(10) - 90
    assert_equal '08:30', clock.to_s
  end

  def test_wrap_around_at_negative_midnight
    clock = Clock.at(0, 30) - 60
    assert_equal '23:30', clock.to_s
  end

  def test_subtract_more_than_a_day
    clock = Clock.at(10) - 3061
    assert_equal '06:59', clock.to_s
  end

  def test_equivalent_clocks
    clock1 = Clock.at(15, 37)
    clock2 = Clock.at(15, 37)
    assert_equal clock1, clock2
  end

  def test_inequivalent_clocks
    clock1 = Clock.at(15, 37)
    clock2 = Clock.at(15, 36)
    clock3 = Clock.at(14, 37)
    refute_equal clock1, clock2
    refute_equal clock1, clock3
  end

  def test_wrap_around_backwards
    clock1 = Clock.at(0, 30) - 60
    clock2 = Clock.at(23, 30)
    assert_equal clock1, clock2
  end
end