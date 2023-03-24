# Character Classes 

# Patterns allow for specification of a set of characters to match. 


# Set of Characters 

  # Use list of characters between square brackets: /[abc]/
    # Pattern matches a single occurrence of any character between the brackets

  
  # Return array of words that contain an x, y, or z:

    str = "I fax sparingly at the zoo"

    words = []

    str.split.each do |word|
      words << word if word.match(/[xyz]/)
    end 

    p words # ["fax", "sparingly", "zoo"]




  # Return true if string matches the word "surf". 's' may be lower or uppercase, but the rest of the word must be lowercase. 

    str1 = 'Surfer'
    str2 = 'SURFER'
    str3 = 'surf'
    str4 = 'surF'

    arr = [str1, str2, str3, str4]

    p arr.select { |word| word.match(/[sS]urf/)} 

    # => ["Surfer", "surf"]

  


  # Concatenating character classes

    w1 = "a2"
    w2 = "Model 640c1"
    w3 = "a1 a2 a3 b1 b2 b3 c1 c2 c3 d1 d2 d3"

    # match any two chars where first char is a, b, or c; second char is 1 or 2.

    p w1.match?(/[abc][12]/)    # true




  

  # Meta characters in character classes: ^ \ - [ ]


    

  # Range of Characters 

  str = "hello"

  str.match?(/[a-zA-Z]/)    # true





  # Negated Classes 

  # First char between brackets is a ^ 

    # Matches all chars not identified in the range.


    arr = %w(yes a by +/- ABCXYZ y yyyy yyayy)

    p arr.select { |word| word.match(/[^a-z]/)}  
    
    # => ["+/-", "ABCXYZ"] matches everything not in range a-z lowercase. 

  
# ** REMEMBER** 

# `match` returns a truthy value when there is a match anywhere in the string.

text = 'xyx'
puts 'matched' if text.match?(/[^x]/)

# => matched 


#
#
#


# Exercises: 



# Write a regex that matches uppercase or lowercase Ks or a lowercase s.
    # expect 6 matches.

arr = %w(Kitchen Kaboodle Reds and blues kitchen Servers)

p arr.select { |word| word.match(/[kKs]/)}

# => ["Kitchen", "Kaboodle", "Reds", "blues", "kitchen", "Servers"]





# Write a regex that matches any of the strings cat, cot, cut, bat, bot, or but, regardless of case. Expect 8 word matches.

arr = %w(My cats, Butterscotch and Pudding, like to
  sleep on my cot with me, but they cut my sleep
  short with acrobatics when breakfast time rolls
  around. I need a robotic cat feeder.)

  p arr.select { |word| word.match(/[bc][aou]t/i) }

# => ["cats,", "Butterscotch", "cot", "but", "cut", "acrobatics", "robotic", "cat"]





# Base 20 digits include the decimal digits 0 through 9, and the letters A through J in upper or lowercase. Write a regex that matches base 20 digits. Expect 28 matches.

str1 = "0xDEADBEEF" 
str2 = "1234.5678" 
str3 = "Jamaica" 
str4 = "plow"
str5 = "ahead"

arr = [str1, str2, str3, str4, str5]

counter = 0 

arr.each do |str|
  str.each_char do |char|
    counter += 1 if char.match(/[0-9A-Ja-j]/)
  end 
end 

p counter  # > 28 





# Write a regex that matches any letter except x or X. Expect 82 matches.

str = "0x1234 Too many XXXXXXXXXXxxxxxxXXXXXXXXXXXX to count. The quick brown fox jumps over the lazy dog THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"

counter = 0

str.each_char { |char| counter += 1 if char.match(/[A-WYZa-wyz]/) }

p counter  # => 82 






# Why is /[^xX]/ not a valid answer to previous question?

  # this matches everything except x or X, including whitespace, punctuation, etc.
  # we were looking to match any letter other than x or X.




# Write a regex that matches any character that is not a letter. Expect 45-46 matches.

str = "0x1234abcd 1,000,000,000s and 1,000,000,000s. THE quick BROWN fox JUMPS over THE lazy DOG!"

counter = 0 

str.each_char { |char| counter += 1 if char.match(/[A-Za-z]/) }

p counter  # => 45







# Are /(ABC|abc)/ and /[Aa][Bb][Cc]/ equivalent regex? If not, how do they differ? Can you provide an example of a string that would match one of these regex, but not the other?


  # No they are not equivalent. 

    # /(ABC|abc)/ matches either "ABC" or "abc"

    # /[Aa][Bb][Cc]/ matches any case combination of the three letters

      # "AbC" would not match first regex but will match second. 
      # Any string that matches the first will also match second, not vice versa.






# Are /abc/i and /[Aa][Bb][Cc]/ equivalent regex? If not, how do they differ? Can you provide an example of a string that would match one of these regex, but not the other?

  # Yes, they are functionally equivalent 






# Challenge: write a regex that matches a string that looks like a simple negated character class range, e.g., '[^a-z]'. (Your answer should match precisely six characters. The match does not include the slash characters.) Expect 3 matches.

text = "The regex /[^a-z]/i matches any character that is
not a letter. Similarly, /[^0-9]/ matches any
non-digit while /[^A-Z]/ matches any character
that is not an uppercase letter. Beware: /[^+-<]/
is at best obscure, and may even be wrong."

p text.match?(/\[\^[a-zA-Z0-9]-[a-zA-Z0-9]\]/)   # true