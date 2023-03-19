# Diamond 

# The diamond exercise takes as its input a letter, and outputs it in a diamond shape. 

# Given a letter, it prints a diamond starting with 'A', with the supplied letter at the widest point.

=begin

Examples: 

A returns:

A


C returns: 

  A
 B B
C   C
 B B
  A


E returns: 
    A
   B B
  C   C
 D     D
E       E
 D     D
  C   C
   B B
    A

P: 

Rules: 

# - The first row contains one 'A'.
# - The last row contains one 'A'.
# - All rows, except the first and last, have exactly two identical letters.
# - The diamond is horizontally symmetric.
# - The diamond is vertically symmetric.
# - The diamond has a square shape (width equals height).
# - The letters form a diamond shape.
# - The top half has the letters in ascending order.
# - The bottom half has the letters in descending order.
# - The four corners (containing the spaces) are triangles.

Implicit from test_cases
  - Diamond class
  - #make_diamond instance method 
  - return value should be string 
  - uppercase characters

E: above

  - Experimenting with C as an example

  - Notes: 
    - C is the third letter of the alphabet 
    - middle of diamond will be two C's, first position, spaces, last position
    - 

  A    # 2 spaces before A 
 B B   # 1 space before B, one space, another B 
C   C  # 0 spaces before C, three spaces, another C 
 B B   # same 
  A    # same 

---

  - Experiment with E as an example: 

  - Notes: E is the 5th letter in the alphabet 
  - middle will be two E's

    A      # 4 spaces before A (5-1)
   B B     # 3 spaces before B, one space, another B 
  C   C    # 2 spaces before C, three spaces, another C
 D     D   # 1 space before D, 5 spaces, another D 
E       E  # 0 spaces before E, 7 spaces, another E
 D     D
  C   C
   B B
    A

Start_spaces = input letter position - 1
  Reduce by 1 for each subsequent letter down to zero 

Middle_spaces = increment by 2, starting from 1 with B
  0 for A 
  1 for B
  3 for C 
  5 for d
  7 for e

Track: 

  - input letter alphabetic position 
  - start_spaces
  - middle_spaces 
  - repeat upper half once reach input letter line.

---

Example: make_diamond('G')

  input_position: 7
  start_spaces: 6 for A, 5 for B, 4 for C, 3 for D, 2 for E, 1 for F, 0 for G
  middle_spaces: 0, 1 for B, 3 for C, 5 for D, 7 for E, 9 for F, 11 for G 
  reverse or reset?

D:
string input
integers for calculating spaces 
return value is string 

A: for # make_diamond(letter)

- initialize alphabet array (A..Z).to_a
- determine input letter position and save to local var
- initialize start_spaces to letter position - 1
- initialize middle spaces to 1

- Create alphabet range A to input
- iterate through up to input 
- iterate backward from second to last element coming back 


  ex. C
        [A, B, C]

    start_spaces + "A" 
      - start_spaces - 1
    start_spaces + "B" + middle_spaces + "B"
      - start_spaces - 1
      - middle spaces + 2

    start_spaces + "C" + middle_spaces + "C"     #MIDDLE
      - start_spaces + 1
      - middle_spaces - 2
    
    start_spaces + "B" + middle_spaces + "B"
      - start_spaces + 1
      - middle_spaces - 2
    start_spaces + "A"

=end 

def upper_half_diamond(letter)
  alpha_position = (letter.downcase.ord) - 96
  letter_range = ('A'..letter).to_a
  pre_space = alpha_position - 1
  between_space = 0

  letter_range.each do |char|
    if char == 'A'
      puts "#{" " * pre_space}#{char}"
      pre_space -= 1 
      between_space += 2 
    else 
      puts "#{" " * pre_space}#{char}#{" " * between_space}#{char}"
      pre_space -= 1
      between_space += 2 
    end 
  end 
end 

def lower_half_diamond(letter)
  pre_space = 1 
  between_space = (0..49).to_a
  alpha_position = (letter.downcase.ord) - 96
  now_between = between_space[alpha_position]
  letter_range = ('A'..letter).to_a.reverse 
  p now_between

  letter_range.each do |char|
    if char == 'A' 
      puts "#{" " * pre_space}#{char}"
    else 
      puts "#{" " * pre_space}#{char}#{" " * now_between}#{char}"
      pre_space += 1
      now_between -= 2
    end 
  end 
end 

def make_diamond(letter)
  upper_half_diamond(letter)
  lower_half_diamond(letter)
end 

make_diamond('G')

 




    
