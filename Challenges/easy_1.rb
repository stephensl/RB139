=begin
  Write a program to determine whether a triangle is equilateral, isosceles, or scalene.

An equilateral triangle has all three sides the same length.

An isosceles triangle has exactly two sides of the same length.

A scalene triangle has all sides of different lengths.

Note: For a shape to be a triangle at all, all sides must be of length > 0, and the sum of the lengths of any two sides must be greater than the length of the third side.

---

Problem: 

  Classify triangles based on the length of its sides. 

  Explicit: 

    - Valid triangle must have each side > 0
    - Valid triangle must have sum of any two sides > length of remaining side
    - Equilateral has all equal sides. 
    - Isosceles has two equal sides 
    - Scalene has three unequal sides. 



Examples: 

  Provided test cases indicate: 

    - Triangle class 
    - Constructor method that takes three arguments representing side lengths
      - Exception raised if not valid triangle (helper)
    - #kind instance method that returns the type of triangle in string form


Data Structures: 

  - Test cases indicate that we will use numbers to create new Triangle and classify it
  - Return value is a string
  - Side lengths may be stored in array 


Algorithm:

  - Define Triangle class 
  
  - Constructor 
    - define method to accept three arguments 
    - valid_triangle? (helper method)
    - assign sides in an array to instance variables 
  
  - valid_triangle method
    - define method to accept an array
    - check if any length in array is <= 0
      - if so, return false 
    - check if sum of any two sides < length of remaining side 
  
  - kind method 
    - Compare sides of triangle:
    - if all equal return 'equilateral'
    - if two equal, return 'isosceles'
    - if all unique, return 'scalene' 

Code: 
=end 

class Triangle 
  attr_reader :side_1, :side_2, :side_3, :all_sides 

  def initialize(*sides)
    @side_1, @side_2, @side_3 = sides 
    raise(ArgumentError, "Not a valid triangle") unless valid_triangle?(sides)
    @all_sides = sides
  end 

  def kind 
    case all_sides.uniq.size 
      when 1 then "equilateral"
      when 2 then "isosceles"
      when 3 then "scalene"
      else "Error. Is this really a valid triangle?"
    end
  end 

  private 

  def valid_triangle?(arr)
    arr.all? {|side| side > 0} &&
    side_1 + side_2 > side_3 &&
    side_1 + side_3 > side_2 &&
    side_2 + side_3 > side_1 
  end 
end 

# Testing File: tests_easy_1.rb

# Run options: --seed 39650

# # Running:

# ................

# Finished in 0.018406s, 869.2770 runs/s, 869.2770 assertions/s.

# 16 runs, 16 assertions, 0 failures, 0 errors, 0 skips

