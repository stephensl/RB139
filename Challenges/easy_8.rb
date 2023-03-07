# Sum of Multiples 

=begin
  
Write a program that, given a natural number and a set of one or more other numbers, can find the sum of all the multiples of the numbers in the set that are less than the first number. If the set of numbers is not given, use a default set of 3 and 5.

For instance, if we list all the natural numbers up to, but not including, 20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of these multiples is 78.

---
---

Problem: 

Given a natural number (x) and one or more other numbers (*y), find all the multiples of *y that exist up to one less than x. Return the sum of these multiples. If no argument (y) then default to 3 and 5. 

Rules: 

  - first argument is x (natural number)
  - if no additional arguments given, find multiples of 3 or 5 up to x-1


Examples: 

    - Test cases provided
      - Need class method ::to that can be called with one argument. 
      - Constructor method that takes multiple arguments *set
        - assign to instance variable @target_multiples
      - instance method #to() that takes one argument (natural number)


Data Structures:

    - integer values given 
    - array to store numbers to sum
    - return integer value

Algorithm: 

- Define class SumOfMultiples
    - constructor 
      - accepts multiple arguments (list)
      - if no arguments given, assign iv to [3,5]

    - instance method #to()
      - accepts one argument(natural number)
      - create range 1...natural num
      - iterate through range
        - for each number in range, check if multiple of any number in multiples list
          - if so, move to saved valid multiples array 
      - sum valid multiples array
      - return sum 

    - class method ::to()
        - accepts one argument(natural number)
        - create range 1...natural num 
        - iterate through range
            - for each num in range check to see if multiple of 3 or 5
              - if so, add to saved multiples array 
        - sum array and return sum.

=end 


class SumOfMultiples
  attr_reader :target_multiples

  def self.to(natural_num)
    SumOfMultiples.new.to(natural_num) 
  end 

  def initialize(*list)
    @target_multiples = list.empty? ? [3, 5] : list
  end 

  def to(natural_num)
    (1...natural_num).select do |num|
      target_multiples.any? { |mult| num % mult == 0 }
    end.sum
  end 
end 



# Testing 

# Run options: --seed 31607

# # Running:

# .........

# Finished in 0.017642s, 510.1347 runs/s, 510.1347 assertions/s.

# 9 runs, 9 assertions, 0 failures, 0 errors, 0 skips
