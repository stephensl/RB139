# Octal 

=begin   

Implement octal to decimal conversion. Given an octal input string, your program should produce a decimal output. Treat invalid input as octal 0.

Note: Implement the conversion yourself. Don't use any built-in or library methods that perform the necessary conversions for you. In this exercise, the code necessary to perform the conversion is what we're looking for.

---
---

Problem:

Given an octal input string, convert it to a decimal number. 

input: string number 
output: integer (decimal number)

rules: 
  - octal numbers use base 8 system
  - rightmost digit multiplied by 8**0
  - next digit (right to left) multiplied by 8**1
  - continue (last digit multiplied by 8**n-1)
  - decimal number is sum of these operations


Examples: test cases provided.

  - Octal class
  - constructor method
    - accepts one argument 
  - to_decimal instance method

  - invalid numbers 
    - any number containing digit greater than 7
    - any number containing alphabetic characters

  - leading zero is valid octal number (011)


Data Structures: 

string input

array of digits (split octal number digits)

transforming digits to integers 

returning integer value


Algorithm: 

- Define class Octal
- Constructor 
  - accepts one argument 
  - save arg to value instance variable 

- to_decimal instance method 
  - split input number into array of digits
  - check to make sure all valid digits (0-7)
  - transform each string digit to integer value
  - iterate backward through each integer in array 
    - multiply by increasing powers of 8... 8**0, 8**1, 8**2 ...
    - save products to array
    - sum array
  - return integer value 


code: 

=end 

class Octal 
  attr_reader :value

  def initialize(num)
    @value = num
  end 

  def to_decimal 
    return 0 unless valid_octal?

    digit_arr = value.split('').map(&:to_i)
    raised_values = []

    digit_arr.reverse_each.with_index do |digit, power|
      raised_values << (digit * (8**power))
    end 

    raised_values.sum 
  end 

  private 

  def valid_octal?
    !value.match?(/[^0-7]/)
  end 

end 

# Testing

# Run options: --seed 1692

# # Running:

# ...............

# Finished in 0.013835s, 1084.1754 runs/s, 1084.1754 assertions/s.

# 15 runs, 15 assertions, 0 failures, 0 errors, 0 skips