# Series 

=begin   

Write a program that will take a string of digits and return all the possible consecutive number series of a specified length in that string.

For example, the string "01234" has the following 3-digit series:

    012
    123
    234

Likewise, here are the 4-digit series:

    0123
    1234

Finally, if you ask for a 6-digit series from a 5-digit string, you should throw an error.

---
---

Problem: 

Given a string of digits (x) and a specified length (y) return all possibilities of (y) consecutive numbers from the input string. 

input: string of digits (0-9+), and length argument integer <= length of string
output: array of subarrays, with each subarray containing each set of (y) consecutive numbers from x.

rules: 
  - if consecutive series length > length of input string, throw error
  - numbers should be consecutive as they appear in input string 
  - each set of (y) consecutive numbers should be contained in a (y) element array as integers and stored as an element of a larger array

Examples: 
    - Series class 
    - constructor method takes single argument (number string)
      - assigns number string to instance variable 
    - #slices instance method
      - takes one argument (length of consecutive numbers desired) 
      - returns an array containing subarrays made up of consecutive elements of indicated length
    
Data Structures: 

    - string argument for number series
    - integer argument for slices method
    - arrays to store slices
    - array to store subarrays of slices to return 

Algorithm: 

    - Define class Series

      - constructor 
        - accepts one argument (string)
        - assigns string to instance variable 

      - #slices method
        - accepts one argument (integer)
        - create empty results array 
        - iterate through input string
        - save consecutive numbers in string with length determined by integer argument to subarray
        - add subarray to results array
        - continue until all combinations complete
        - return results array

Code: 
=end 

class Series
  def initialize(str)
    @number_string = str
  end 

  def slices(int)
    raise ArgumentError if int > @number_string.length 
    
    results_array = []

    0.upto(@number_string.length - int) do |start_index|
      results_array << (@number_string[start_index, int]).split('').map(&:to_i)
    end
    
    results_array 
  end 
end 


# Testing 

# Run options: --seed 25001

# # Running:

# ..............

# Finished in 0.013534s, 1034.4318 runs/s, 1034.4318 assertions/s.

# 14 runs, 14 assertions, 0 failures, 0 errors, 0 skips