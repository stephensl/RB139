# Beer Song

=begin   

Write a program that can generate the lyrics of the 99 Bottles of Beer song. See the test suite for the entire song.

---
---

Problem: 

Create template for generating lyrics to 99 bottles of beer song. 

input: verse number, range, or request for full lyrics
output: string verse possibly continuing down based on arguments 

Rules: 
  - class method ::verse(num)
    - returns full verse based on argument.
  - class method ::lyrics
    - returns full lyrics from 99 down to 0
  - class method ::verses(1, 2)
    - accepts two arguments
    - return verses in range inclusive


Example: test cases provided 



Data Structures: 

Strings, numbers to track verses, array to hold lyrics if needed


Algorithm: 

Define class BeerSong
  - ::verse method 
    - accepts one argument 0-99
    - returns verse with proper verse number interpolated
  - 