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




# 



