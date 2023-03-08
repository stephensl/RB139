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
  - :: verses method
    - accepts two arguments, start, end
    - returns verse from first argument up to or down to second. 
  - ::lyrics method
    - returns all lines 

C:
=end 

class BeerSong 
  NUMBER_AND_TENSE = {
    (0)
  }
  def self.verse(num)
    if num > 1
     "#{num} bottles of beer on the wall, #{num} bottles of beer.\n" \
        "Take one down and pass it around, #{num - 1} bottles of beer on the wall.\n" \
    elsif num == 1
      "#{num} bottle of beer on the wall, #{num} bottle of beer.\n" \
        "Take it down and pass it around, no more bottles of beer on the wall.\n" \
    else 
     "No more bottles of beer on the wall, no more bottles of beer.\n" \
        "Go to the store and buy some more, 99 bottles of beer on the wall."
    end 
  end

  def self.verses(start, finish)
    start.downto(finish) do |num|
      verse(num)
    end
  end 

  def self.lyrics
    verses(99, 0)
  end 
end

BeerSong.verses(99, 80)