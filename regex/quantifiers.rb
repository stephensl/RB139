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






# Write a regex that matches the last word in each line of text. For this exercise, assume that words are any sequence of non-whitespace characters. Expect 5 matches. 


str = "What's up, doc?
I tawt I taw a putty tat!
Thufferin' thuccotath!
Oh my darling, Clementine!
Camptown ladies sing this song, doo dah."


p str.scan(/\S+$/)  

# => ["doc?", "tat!", "thuccotath!", "Clementine!", "dah."]




# Write a regex that matches lines of text that contain at least 3, but no more than 6, consecutive comma separated numbers. 

# You may assume that every number on each line is both preceded by and followed by a comma. 

str = ",123,456,789,123,345,
,123,456,,789,123,
,23,56,7,
,13,45,78,23,45,34,
,13,45,78,23,45,34,56,"

/^,(\d+,){3,6}$/




# Write a regex that matches lines of text that contain at least 3, but no more than 6, consecutive comma separated numbers. In this exercise, you can assume that the first number on each line is not preceded by a comma, and the last number is not followed by a comma. 


str = "123,456,789,123,345
123,456,,789,123
23,56,7
13,45,78,23,45,34
13,45,78,23,45,34,56"

/^(\d+,){2,5}\d+$/




# Challenge: Write a regex that matches lines of text that contain either 3 comma separated numbers or 6 or more comma separated numbers. 

str = "123,456,789,123,345
123,456,,789,123
23,56,7
13,45,78,23,45,34
13,45,78,23,45,34,56"

/(^(\d+,){2}\d+$|^(\d+,){5,}\d+$)/





# Write a regex that matches HTML h1 header tags, and the content between the opening and closing tags. If multiple header tags appear on one line, your regex should match the opening and closing tags and the text content of the headers, but nothing else. You may assume that there are no nested tags in the text between <h1> and </h1>.

text = "<h1>Main Heading</h1>
<h1>Another Main Heading</h1>
<h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1><p>Done</p>"


/<h1>.*?<\/h1>/