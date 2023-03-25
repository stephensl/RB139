# Anchors 

# Anchors limit regex matches by telling regex engine where matches can begin and end. 

  # Anchors do not match any characters, they only ensure that a regex matches a string at a specific place. 

    # Beginning of line or string 
    # End of line or string 
    # Word boundary 
    # Non-word boundary 



# Start/End of Line 

  # Meta Characters: 
    # ^  : beginning of line 
    # $  : end of line 

  # Examples: 

  str1 = "cat"
  str2 = "catastrophe"
  str3 = "wildcat"
  str4 = "I love my cat"
  str5 = "<cat>"


  arr = [str1, str2, str3, str4, str5]

  p arr.select { |word| word.match(/^cat/) }

  # => ["cat", "catastrophe"]

    # cat pattern is forced to beginning of line. 

  

  
  # Using the $ on the same strings: 

  arr = [str1, str2, str3, str4, str5]

  p arr.select { |word| word.match(/cat$/) }

    # => ["cat", "wildcat", "I love my cat"]

  


  # Using both ^ and $ : line must begin and end with pattern.

  arr = [str1, str2, str3, str4, str5]

  p arr.select { |word| word.match(/^cat$/) }

    # => ["cat"] from str1





# Lines vs Strings (Ruby only)

  # Subtlety when string has one or more newline characters that are not the last char in the string. 

  # Example: 

  TEXT1 = "red fish\nblue fish"
  puts "matched red" if TEXT1.match(/^red/)
  puts "matched blue" if TEXT1.match(/^blue/)

    # => matched red 
    # => matched blue 

  # The ^ anchors regex to beginning of each line in the string, not beginning of string. 

  # Each new line occurs after a \n character. 
  # The beginning of the string is the beginning of the first line. 
  # The line runs through and includes the \n
    # If no more \n chars available, the last line runs through end of string. 

  
  # Example: 

  TEXT2 = "red fish\nred shirt"
  puts "matched fish" if TEXT2.match(/fish$/)
  puts "matched shirt" if TEXT2.match(/shirt$/)

  # => matched fish 
    # even though the first line of the string ends with a \n, 'fish' is still the end of the line. 
      # $ does not care if there is a \n char at the end, if there is not more than 1. 

  # => matched shirt 




# Start/End of String (Ruby only)

  # More often, need to match beginning or end of string, not line. 

    # Use \A, \Z, and \z anchors.

      # There is no \a anchor.

  # \A : ensures regex matches at beginning of string. 

  # \Z : matches up to, not including, newline at end of string

  # \z : always matches end of string 

  # ** use \z unless determine \Z is necessary. 


  # Examples: 

  TEXT3 = "red fish\nblue fish"
  TEXT4 = "red fish\nred shirt"

  puts "matched red" if TEXT3.match(/\Ared/)     # => matched red
  puts "matched blue" if TEXT3.match(/\Ablue/)   # 
  puts "matched fish" if TEXT4.match(/fish\z/)   # 
  puts "matched shirt" if TEXT4.match(/shirt\z/) # => matched shirt 

  # This demonstrates that new line, is not new string. 




# Word Boundaries

  