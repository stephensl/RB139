# Anagrams 

=begin 

Write a program that takes a word and a list of possible anagrams and selects the correct sublist that contains the anagrams of the word.

For example, given the word "listen" and a list of candidates like "enlists", "google", "inlets", and "banana", the program should return a list containing "inlets". Please read the test suite for the exact rules of anagrams.

---
---

Problem: 

Anagram is a word that contains the exact same letters and same number of letters as another word. 

  Input: 
    - word (String)
    - array of Strings

  Output: 
    - Array containing strings that are anagrams of input string 

  Rules: 
    - No matches returns empty array []
    - matches should be returned in an array 
    - anagrams are case insensitive
    - returned anagrams should be sorted alphabetically in array
    - identical word is not an anagram


Examples: Based on test cases will need the following: 
      - Anagram class 
        - constructor accepts one argument (string)
      
        - match instance method
          - checks input string to look for anagrams among array of strings
          - if word is anagram add to new array
          - return new array



Data Structures: 
    String, Array ....     return new_array 

    - Array to store characters of strings and sort




Algorithm: 
- Define Anagram class 

- Define initialize method
  - takes one argument (string)
  - assign to instance variable 

- Define match method
  - takes single argument (array)
  - iterate through array word by word 
    - if input word != word && sorted_input_word == sorted_array_word
      - save word in array to new array (results)
  - sort new array and return it. 

Code: 

=end 


class Anagram 
  def initialize(input_word)
    @input_word = input_word 
  end 

  def match(array)
    array.select do |word|
      word if detect_anagram_vs_input(word)
    end.sort
  end 

  private 

  def detect_anagram_vs_input(other_word)
    local_input = @input_word.downcase.strip 
    local_other = other_word.downcase.strip 
  
    local_input != local_other &&
      local_input.chars.sort == local_other.chars.sort 
  end 
end 



# Testing via 'tests_easy_4.rb'

# Run options: --seed 47175

# # Running:

# ..........

# Finished in 0.015175s, 658.9873 runs/s, 658.9873 assertions/s.

# 10 runs, 10 assertions, 0 failures, 0 errors, 0 skips