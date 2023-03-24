# Part 1: Basic Matching 

# Regex matching is a boolean operation. 


  # Alphanumerics 

    str = "the cat in the hat"

    p str.match?(/c/) # Does this string contain the letter 'c'?
                      # outputs true 

    p str.match?(/C/) # outputs false 

    p str.match?(/ca/) # Does this string contain 'ca'?
                       # outputs true 

  

  # Special Characters:  $ ^ * + ? . ( ) [ ] { } | \ /

    # Must escape to match literal rather than meta meaning.

  str = "Are you guys silly? I'm still gonna send it."

  p str.match?(/\?/) # outputs true 



  # Concatenation 

    # The regex /cat/ consists of concatenation of the `c`, `a`, `t` patterns and matches any string that contains a 'c' followed by 'a', then by 't'. 



  # Alternation 

    str = "Welcome to the jungle."

    p str.match?(/(to|too|two)/)  # true 
    
    p str.match?(/(a|b|d)/)       # false 

    p str.match?(/th(i|e)/)       # matches pattern 'th' followed by either 'i' or 'e'



  # Control Character Escapes: \n, \r, \t

    str = "the garden\tis growing\n some good food\n for us to eat."
  
    p str.match?(/\n/) # true 

    p str.match?(/\t/) # true 



  # Ignoring Case: option `i`

    str = 'THE CAT IS FAT'

    p str.match?(/cat/) # false 

    p str.match?(/cat/i) # true 

    

# Exercises

  # Write a regex that matches an uppercase K. Test it with these strings:

  str1 = "Kx"
  str2 = "BlacK"
  str3 = "kelly"

  p [str1, str2, str3].map { |word| word.match?(/K/) }

    # [true, true, false]


  
  # Write a regex that matches the string 'dragon'. Expect 2 matches.

    str = "snapdragon bearded dragon dragoon"

    p str.split.select { |word| word.match?(/dragon/)}

      # ["snapdragon", "dragon"]

  

  # Write a regex that matches any of the following fruits: banana, orange, apple, strawberry. The fruits may appear in other words. Expect 5 matches.

    arr = %w(banana orange pineapples strawberry raspberry grappler)

    count = 0 
    arr.each do |word|
      count += 1 if word.match?(/(banana|orange|apple|strawberry)/)
    end 

    p count  # 5

  
  
  # Write a regex that matches a comma or space. Expect 7 matches. 

    str = "This line has spaces
    This,line,has,commas,
    No-spaces-or-commas"

    p str.match?(/(,| )/)


    
  # Write a regex that matches blueberry or blackberry, but write berry precisely once. Expect 2 matches.

  arr = %w(blueberry blackberry black berry strawberry)

  p arr.count { |word| word.match?(/(blue|black)berry/)}   # 2