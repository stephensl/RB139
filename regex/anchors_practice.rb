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

  # \b matches word boundary
  # \B matches non-word boundary

    # words are sequence of word characters (\w) including (a-z,A-Z,0-9, _)
  

    # Word boundaries occur: 
      # between any pair of characters, one of which is word char, one is not. 
      # beginning of string if first char is a word char 
      # end of string if last char is a word char

    # Non-word boundary:
      # between any pair of chars, both of which are word or non-word chars
      # beginning of string if starts with non-word char
      # end of string if last char is non-word char 

  
  # Example: 

  str = "Eat some food."

    # word boundaries before the E, s, and f at start of each word, and after the t, e, d at end of words. 
    # non-word boundaries elsewhere, such as between the o and m in some, or after the . at the end. 


  
  # ---

  # Match 3 letter word consisting of word characters..can use /\b\w\w\w\b/


  # \b and \B do not work as word boundaries inside of character classes (between square brackets). 
  
  # In fact, \b means something else entirely when inside square brackets: it matches a backspace character.




  # ---
  # ---
  # ---



# Exercises: 


# Write a regex that matches the word 'The' when it occurs at the beginning of a line. 

str1 = "The lazy cat sleeps."
str2 = "The number 623 is not a word."
str3 = "Then, we went to the movies."
str4 = "Ah. The bus has arrived."

matched = []

[str1, str2, str3, str4].each do |str|
  matched << str if str.match(/\AThe\b/)
end 

p matched # => ["The lazy cat sleeps.", "The number 623 is not a word."]






# Write a regex that matches the word cat when it occurs at the end of a line. 

  str1 = "The lazy cat sleeps"
  str2 = "The number 623 is not a cat"
  str3 = "The Alaskan drives a snowcat"



  p [str1, str2, str3].select { |str| str.match(/\bcat\z/) }






#  Write a regex that matches any three-letter word; a word is any string comprised entirely of letters. 

str = "reds and blues"
str2 = "The lazy cat sleeps."
str3 = "The number 623 is not a word. Or is it?"


p str.scan(/\b[a-z][a-z][a-z]\b/i)  # => ["and"]

p str2.scan(/\b[a-z][a-z][a-z]\b/i) # => ["The", "cat"]

p str3.scan(/\b[a-z][a-z][a-z]\b/i) # => ["The", "not"]




# Write a regex that matches an entire line of text that consists of exactly 3 words as follows:

# The first word is A or The.
# There is a single space between the first and second words.
# The second word is any 4-letter word.
# There is a single space between the second and third words.
# The third word -- the last word -- is either dog or cat.



/\A(A|The) [a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z] (dog|cat)\z/


T