# Point Mutations 

=begin
  
Write a program that can calculate the Hamming distance between two DNA strands.

The simplest and most common type of nucleic acid mutation is a point mutation, which replaces one base with another at a single nucleotide.

By counting the number of differences between two homologous DNA strands taken from different genomes with a common ancestor, we get a measure of the minimum number of point mutations that could have occurred on the evolutionary path between the two strands.

This is called the Hamming distance.

GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT
^ ^ ^  ^ ^    ^^

The Hamming distance between these two DNA strands is 7.

The Hamming distance is only defined for sequences of equal length. If you have two sequences of unequal length, you should compute the Hamming distance over the shorter length.

---
---

Problem: 

Given two DNA strands that may be equal or unequal in length, calculate the Hamming Distance between the two strands (number of differences between two). 

  - Input: two DNA strands (Strings)
  - Output: number of differences between the two up to length of shortest strand.

  - Comparing two strings to find number of differences. 
  - Only count differences up to size of shortest string
  - if no difference, return 0
  - empty strands, return 0


Examples: 

    - Requires DNA class 
      - Constructor method that takes one argument (string)
      - assign instance variable @strand to string 
      - hamming distance method called directly on object, takes one argument
        - returns difference in two strands

Data Structures: 

    - Comparing Strings
    - Returning Integers
    - Collection to iterate through strand characters

Algorithm: 

    - Create DNA class

      - Constructor method
        - Accepts one argument, with default empty string 
        - Assigns strand to instance variable @strand

      - Hamming Distance Method
        - calculate shortest string 
        - iterate through shortest string by character
          - compare to character at same index in other string
          - if characters are different, increment differences counter. 
        - return differences counter. 

Code: 

=end 

class DNA
  attr_reader :strand
  def initialize(strand='')
    @strand = strand
  end 

  def hamming_distance(other)
    shortest = (strand.length < other.length ? strand : other).chars
    counter = 0

    shortest.size.times do |idx|
      counter += 1 unless strand[idx] == other[idx]
    end 

    counter 
  end 
end 

---
---

# Testing

# Run options: --seed 31843

# # Running:

# .........

# Finished in 0.015889s, 566.4225 runs/s, 692.2941 assertions/s.

# 9 runs, 11 assertions, 0 failures, 0 errors, 0 skips