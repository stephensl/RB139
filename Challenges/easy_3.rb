# Roman Numerals

=begin
  
Write some code that converts modern decimal numbers into their Roman number equivalents.

---
---

Problem: 

Given a decimal number, convert it to its Roman Numeral representation.

  1 => I
  5 => V
  7 => VII 
  10 => X 
  50 => L
  90 => XC 
  100 => C
  500 => D
  900 => CM
  1000 => M
  2000 => MM 


  Input: decimal number as integer 
  Output: string representation of number as Roman Numeral

  Rules: 
    - Don't worry about numbers greater than 3,000
    - Roman Numerals written by expressing each digit of the number separately, starting with left most digit and skipping any digit with value zero.



Examples: 

- RomanNumeral class
  - Constructor method takes one argument(integer)
  - #to_roman method
    - transforms to string representation as Roman Numeral 


Data Structures: 
  hash with conversions?
  integer input
  string return value 


  Algorithm: 

  - Create RomanNumeral class 

    - Constructor accepts one argument (integer)
      - Argument assigned to instance variable 

    - #to_roman instance method
      - accepts one argument (integer)
      - start with leftmost digit value
        - convert to roman numeral using reference hash
        - continue left to right until hit last digit.
        - return string of roman numeral 
    
    - CONSTANT hash
      - Holds conversions key as integer, roman numeral as value 
      - descending order 

Code: 

=end 


class RomanNumeral 
  CONVERSIONS = {
    1000 => 'M', 
    900 => 'CM', 
    500 => 'D', 
    400 => 'CD', 
    100 => 'C', 
    90 => 'XC', 
    50 => 'L', 
    40 => 'XL', 
    10 => 'X', 
    9 => 'IX', 
    5 => 'V', 
    4 => 'IV', 
    1 => 'I'
  }
  
  def initialize(value)
    @value = value 
  end 

  def to_roman 
    numerals = ''
    local_value = @value.dup
    
    CONVERSIONS.each do |int, rom| 
      while local_value >= int 
        local_value -= int 
        numerals << rom 
      end 
    end 

    numerals 
  end 
end 


# Testing with tests.easy_3.rb

# Run options: --seed 11456

# # Running:

# ..................

# Finished in 0.018440s, 976.1282 runs/s, 976.1282 assertions/s.

# 18 runs, 18 assertions, 0 failures, 0 errors, 0 skips