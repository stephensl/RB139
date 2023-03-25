# Character class shortcuts 


# Any character 

  # /./ matches any char except newline characters. 

    # if need to match newline chars as well, use /m option (multiline)

    # /[.]/  matches literal . 



# Whitespace 

  # \s matches whitespace chars
    # include space, tab, vertical tab, carriage return, line feed, and form feed.
    # equivalent to /[ \t\v\r\n\f]/
  
  
  # \S matches non-whitespace chars 
    # equivalent to /[^ \t\v\r\n\f]/ 

  
  # Examples: 

  puts 'matched 1' if 'Four score'.match(/\s/) # matched 1
  puts 'matched 2' if "Four\tscore".match(/\s/) # matched 2
  puts 'matched 3' if "Four-score\n".match(/\s/) # matched 3
  puts 'matched 4' if "Four-score".match(/\s/)   


  puts 'matched 1' if 'a b'.match(/\S/) # matched 1 
  puts 'matched 2' if " \t\n\r\f\v".match(/\S/)

  

  # Use within or outside of square brackets []

    # Outside: /\s/ stands for one of the whitespace characters 
    # Inside: /[a-z\s]/ alternative to other class members
      # any char a-z or any whitespace character 






# Digits and Hex Digits 

  # Decimal digits 0-9
  # Hexadecimal digits 0-9, A-F, a-f 

  # \d  any decimal digit 
  # \D  any char except a decimal digit 
  # \h  any hexadecimal digit (Ruby)
  # \H  any char except hexadecimal digit 


  # Examples: 

  str = "Launch school"

  p str.match?(/\d/)   # false, no decimal digit
  p str.match?(/\h/)   # true

  str = "July 4th, 1776"

  p str.match?(/\d/)   # true 
  p str.match?(/\s/)   # true 





# Word Characters 

  # Word characters are all alphabetic chars (a-z,A-Z), all decimal digits (0-9), and an _ underscore. 

  # \w matches any word character 
  # \W matches any non-word character 


  # Examples: 

    str = "Launch school"

    p str.match?(/\w/)  # true 
  

    str = "one_word_two_words"

    p str.match?(/\W/)  # false, no non-word chars 






# Exercises 

# Write a regex that matches any sequence of three characters delimited by whitespace characters (the regex should match both the delimiting whitespace and the sequence of 3 characters). 

  str = "reds and blues"
  str2 = "the lazy cat sleeps"

  p str.scan(/\s...\s/)  # => [" and "]

  p str2.scan(/\s...\s/) # => [" cat "]




# Test the pattern /\s...\s/ against this text:

  str = "Doc in a big red box"
  str2 = "Hup! 2 3 4"
  
  p str.scan(/\s...\s/) # => [" big "]
  p str2.scan(/\s...\s/)  # => [" 2 3 "]

 # The match is 5 characters long: 
 
  # in str it matches " big " 
  # in str2 it matches " 2 3 "

# The reason it does not match:
  # Doc- no leading whitespace
  # red- leading whitespace consumed by " big "
  # box- period follows it, not whitespace 
  # Hup!- no leading whitespace and exclamation point follows 

  # *** Once consumed as part of a match, the character is no longer available for subsequent matches. 



# Write a regex that matches any four digit hexadecimal number that is both preceded and followed by whitespace. Note that 0x1234 is not a hexadecimal number in this exercise: there is no space before the number 1234. Expect 4 matches. 

str1 = "Hello 4567 bye CDEF - cdef\n"
str2 = "0x1234 0x5678 0xABCD"
str3 = "\n1F8A done"

p str1.scan(/\s[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]\s/)
  # => [" 4567 ", " CDEF ", " cdef\n"]

p str2.scan(/\s\h\h\h\h\s/)
  # => []

p str3.scan(/\s\h\h\h\h\s/)
  # => ["\n1F8A "]




# Write a regex that matches any sequence of three letters. expect 7 matches.

str = "The red d0g chases the b1ack cat.
a_b c_d"

p str.scan(/[a-z][a-z][a-z]/i)
  # => ["The", "red", "cha", "ses", "the", "ack", "cat"]




