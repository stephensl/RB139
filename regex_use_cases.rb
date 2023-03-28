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

