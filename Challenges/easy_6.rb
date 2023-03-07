# Perfect Number 

=begin   

The Greek mathematician Nicomachus devised a classification scheme for natural numbers (1, 2, 3, ...), identifying each as belonging uniquely to the categories of abundant, perfect, or deficient based on a comparison between the number and the sum of its positive divisors (the numbers that can be evenly divided into the target number with no remainder, excluding the number itself). For instance, the positive divisors of 15 are 1, 3, and 5. This sum is known as the Aliquot sum.

Perfect numbers have an Aliquot sum that is equal to the original number.
Abundant numbers have an Aliquot sum that is greater than the original number.
Deficient numbers have an Aliquot sum that is less than the original number.


Write a program that can tell whether a number is perfect, abundant, or deficient.

---
---
---

Problem: 

Create program that, given a number, will calculate the Aliquot sum and determine whether the number is perfect, abundant, or deficient. 

Input: Natural number (1, 2, 3, 4...)
Output: string (perfect, abundant, deficient)

Rules: 
  - Determine Aliquot sum by adding all divisors together (other than number itself)
    - example: 10 --> 1, 2, 5 ... Aliquot sum is 8.. 8 < 10...classified deficient.
  - Perfect numbers have AS == input number
  - Abundant numbers have AS > input number 
  - Deficient numbers have AS < input number 
  - Prime numbers always deficient, as divisor is 1. 



Examples: 
  - Test cases provided. 
  
  - Class should include: 
    - class method ::classify
      - Takes one argument (num)
      - throws error if num is not natural number 
      - returns string classifying the number argument 



Data Structures: 
  - Integer input as argument to classiify method
  - Array to store divisors 
  - Addition of integer values 
  - String return value for classify method


Algorithm: 

  - Define class 
    - Define class method ::classify 
      - accepts one argument (integer > 0)
        - Throws error if argument < 0
      - calculate all divisors of number (not including number itself)
      - add divisors together to get Aliquot Sum
      - Compare Aliquot sum to original number
        - If AS < num then return deficient
        - if AS > num then return abundant
        - if AS == num then return perfect. 


  - Finding Divisors 
    - iterate from 1 up to square root of number to get 'divisor'
    - check if number % divisor == 0 
      - if so, add to divisors array
    - return array of divisors (unique values)


  Code: 

=end 

class PerfectNumber
  def self.classify(number)
    raise(StandardError) if number < 1

    aliquot_sum = find_divisors(number).sum 
    
    case aliquot_sum 
    when 1...number then 'deficient'
    when (number + 1).. then 'abundant'
    when number then 'perfect'
    end 
  end 

  def self.find_divisors(number)
    valid_divisors = []

    1.upto(number - 1) do |divisor|
      valid_divisors << divisor if number % divisor == 0 
    end 

    valid_divisors
  end 
end 


# Testing 

# Run options: --seed 53482

# # Running:

# ....

# Finished in 0.013566s, 294.8656 runs/s, 294.8656 assertions/s.

# 4 runs, 4 assertions, 0 failures, 0 errors, 0 skips


