# Quantifiers 



### Zero or More


# *    : matches 0 or more occurrences of pattern to its left

  # example: /\b\d\d\d\d*\b/

    # matches three consecutive digits beginning at word boundary, followed by any number of digits, and then another word boundary. 



  # example: /co*t/ 

    # matches c, followed by zero or more occurrences of 'o', followed by 't'




# Grouping with * quantifier

  #  /1(234)*5/

    # matches 1 followed by 
    # zero or more occurrences of 234 followed by 
    # 5


  # This would match: 
      # 15
      # 12345
      # 12342342345

  # Would not match:
      # 1234235





### One or more:  + quantifier 


  # matches 1 or more occurrences.





### Zero or One:    ? 

  # optional pattern, either occurs once, or not at all.





### Ranges :     {} 

  # p{m} matches precisely m occurrences of pattern p.
  # p{m,} matches m or more occurrences of p. 
  # p{m, n} matches m or more occurrences of p, but not more than n.




  # Example: check if string contains precisely 10 digits.

    # /\b\d{10}\b/


  # Example: match numbers at least 3 digits in length

    # /\b\d{3,}\b/


  # Example: match words of 5-8 letters.

    # /\b[a-z]{5,8}\b/i

    





### Greediness 

  # The quantifiers discussed will match longest possible string they can.


  # Example: 

    str = "xabcbcbacy"

    p str.scan(/a[abc]*c/)    # => ["abcbcbac"]

      # did not match 'abc' or 'abcbc' which match pattern but shorter than longest possible string match. 






### Lazy Match 

  # match fewest number of characters possible. 

  # add ? after main quantifier. 

    # Example: 

      str = "xabcbcbacy"

      p str.scan(/a[abc]*?c/)   # => ["abc", "ac"]



# ---
# ---
# ---





# Exercises: 



# Write a regex that matches any word that begins with b and ends with an e, and has any number of letters in-between. You may limit your regex to lowercase letters. Test it with these strings.

# expect 4 matches

str = "To be or not to be Be a busy bee I brake for animals."

p str.scan(/\bb[a-z]*e\b/)       # => ["be", "be", "bee", "brake"]






# Write a regex that matches any line of text that ends with a ?. 

str = "What's up, doc?
Say what? No way.
?
Who? What? Where? When? How?"


p str.scan(/^.*\?$/) 

  # => ["What's up, doc?", "?", "Who? What? Where? When? How?"]






# Write a regex that matches any line of text that ends with a ?, but does not match a line that consists entirely of a single ?. Test it with the strings from the previous exercise.

  # There should be two matches.


str = "What's up, doc?
Say what? No way.
?
Who? What? Where? When? How?"


p str.scan(/^.+\?$/) 

  # => ["What's up, doc?", "Who? What? Where? When? How?"]





# Write a regex that matches any line of text that contains nothing but a URL. For this exercise, a URL begins with http:// or https://, and continues until it detects a whitespace character or end of line.

  # expect 2 matches

str = "http://launchschool.com/
https://mail.google.com/mail/u/0/#inbox
htpps://example.com
Go to http://launchschool.com/
https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello
    http://launchschool.com/"


p str.scan(/^https?:\/\/\S*$/)

  # => ["http://launchschool.com/", "https://mail.google.com/mail/u/0/#inbox"]






# Modify your regex from the previous exercise so the URL can have optional leading or trailing whitespace, but is otherwise on a line by itself. To test your regex with trailing whitespace, you must add some spaces to the end of some lines in your sample text.

# There should be three matches.

  /^\s*https?:\/\/\S*\s*$/




# Modify your regex from the previous exercise so the URL can appear anywhere on each line, so long as it begins at a word boundary.

# There should be five matches.

/\bhttps?:\/\/\S*/





# Write a regex that matches any word that contains at least three occurrences of the letter i. 

/\b([a-z]*i){3,}[a-z]*\b/i