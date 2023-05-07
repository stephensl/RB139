# Using regex in Ruby code

# Most useful methods provided by String class


# Matching Strings 


  # match method

    # returns MatchData object- responds to [0], [1], [2]...

    str = "My phone number is 7062025732"

    p str.match(/\b\d{10}$/)    # => #<MatchData "7062025732">

    match_data = str.match(/\b\d{10}$/)

    p match_data[0] # "7062025732"
    p match_data[1] # nil (no capture groups)



  # =~ method 

    # similar to match method
      # returns the index within the string which regex matched, or nil 


      p str =~ /\b\d{10}$/

        # => 19 (index where match started)


  
  # scan method 

    # global form of match
      # returns array of all matching substrings




# Splitting Strings


record = "xyzzy  3456  \t  334\t\t\tabc"
fields = record.split(/\s+/)
# -> ['xyzzy', '3456', '334', 'abc']

  # Splits string on one or more whitespace characters




# Capture Groups 

  # Capture matching characters that correspond to part of a regex, and can be used later in the regex.

  # Suppose you need to match quoted strings inside some text, where either single or double quotes delimit the strings. 

    /(['"']).+?\1/      # backreference to group 1:  it references the first capture group in the regex.

      # The group captures part of the string that matches the pattern between parentheses. 

        #  If the first group matches a double quote, then \1 matches a double quote, but not a single quote.

  




# Transformations

  # String#sub   : transforms first part of string that matches a regex
  # String#gsub  : transforms every part of a string that matches regex


  text = 'Four score and seven'
  vowelless = text.gsub(/[aeiou]/, '*')
  # -> 'F**r sc*r* *nd s*v*n'


  # Using backreferences in the replacement string:

  text = %(We read "War of the Worlds".)
  puts text.sub(/(['"']).+\1/, '\1The Time Machine\1')
    

  # One thing to note here is that if you double quote the replacement string, you need to double up on the backslashes:

  puts text.sub(/(['"]).+\1/, "\\1The Time Machine\\1")








  # Exercises


# Write a method that returns true if its argument looks like a URL, false if it does not.


def url?(text)
  text.match?(/\Ahttps?:\/\/\S+\z/)
end 


p url?('http://launchschool.com')   # -> true
p url?('https://example.com')       # -> true
p url?('https://example.com hello') # -> false
p url?('   https://example.com')    # -> false






# Write a method that returns all of the fields in a haphazardly formatted string. A variety of spaces, tabs, and commas separate the fields, with possibly multiple occurrences of each delimiter.

def fields(text)
  text.split(/[ \t,]+/)

end 



p fields("Pete,201,Student")
# -> ["Pete", "201", "Student"]

p fields("Pete \t 201    ,  TA")
# -> ["Pete", "201", "TA"]

p fields("Pete \t 201")
# -> ["Pete", "201"]

p fields("Pete \n 201")
# -> ["Pete", "\n", "201"]






# Write a method that changes the first arithmetic operator (+, -, *, /) in a string to a '?' and returns the resulting string. Don't modify the original string.


def mystery_math(str)
  str.sub(/[+\-*\/]/, '?')

end 


p mystery_math('4 + 3 - 5 = 2')
# -> '4 ? 3 - 5 = 2'

p mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'






# Write a method that changes every arithmetic operator (+, -, *, /) to a '?' and returns the resulting string. Don't modify the original string.

def mysterious_math(str)
  str.gsub(/[+\-*\/]/, '?')

end 


p mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
p mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'





# Write a method that changes the first occurrence of the word apple, blueberry, or cherry in a string to danish.

def danish(str)
  str.sub(/\b(apple|blueberry|cherry)\b/, 'danish')
end 


p danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

p danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

p danish('The cherry of my eye')
# -> 'The danish of my eye'

p danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

p danish('I love pineapple')
# -> 'I love pineapple'




# Challenge: write a method that changes strings in the date format 2016-06-17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.


def format_date(str)
  str.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1' )  
end 

p format_date('2016-06-17') # -> '17.06.2016'
p format_date('2016/06/17') # -> '2016/06/17' (no change)





# Challenge: write a method that changes dates in the format 2016-06-17 or 2016/06/17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.


def format_date(str)
  str.sub(/\A(\d\d\d\d)[\-\/](\d\d)\2(\d\d)\z/, '\4.\3.\1')

end 


p format_date('2016-06-17') # -> '17.06.2016'
p format_date('2017/05/03') # -> '03.05.2017'
p format_date('2015/01-31') # -> '2015/01-31' (no change)