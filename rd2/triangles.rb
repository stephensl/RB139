# P: Write a class, Triangle, that includes an instance method, @type which 

# equilateral, isosceles, scalene 

  # equilateral all sides same length

  # isosceles two sides same length

  # scalene all sides different. 

# input: three integers 
# output: string 
# 
# E: 

# All sides must be greater than 0
# sum of any two sides must be greater than third side


class Triangle 
  attr_reader :sides 

  def initialize(*sides)
    @sides = sides
    raise(ArgumentError, "invalid triangle") unless valid_triangle?
  end 

  def valid_triangle?
    return false if sides.any? { |side| side <= 0 }
    return false unless sides[0] + sides[1] > sides[2] && 
                        sides[0] + sides[2] > sides[1] && 
                        sides[1] + sides[2] > sides[0] 
  
    true 
  end 

  def kind_of_tri
    return "equilateral" if sides.all? { |side| side == sides[0] }
    return "isosceles" if sides.uniq.size == 2 
    return "scalene" if sides.uniq.size == 3
  end 
end 

mine = Triangle.new(3, 3, 5) 
p mine.valid_triangle?
p mine.kind_of_tri