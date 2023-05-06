=begin
  
Calculate the Hamming Distance between two DNA strands.

By calculating the number of differences in strands. 

Can only be calculated if lengths of strands equal.

If not equal, calculate based on shortest strand

E: 

return 0 if empty strands

return 0 if strands identical 

return integer showing number of differences in strands up to length of shortest strand.

Ignore extra length when not same.

Needs: 

- DNA class
  - one argument to initialize method (string sequence)
  - instance method #hamming_distance
    - returns integer 0 or >


D: 
  input- string
  output- integer 

  string...characters array... integer 

A: 
- define DNA class 
  - initialize method with one arg (strand)
  - set @strand to argument 

- hamming_distance method 
  - takes one argument (strand string)
  - return 0 if empty
  - return 0 if identical 

  - compare in size, and split longer string to only include chars up to size of smallest 

  - iterate through chars in one strand, compare each char to char at same index in other strand.

  - increment counter for each time char != other char

- return count

c: 
=end

class DNA 
  attr_reader :strand 

  def initialize(strand)
    @strand = strand 
  end 

  def hamming_distance(other_strand)
    max_size = strand.size > other_strand.size ? other_strand.size : strand.size 
    diff_count = 0 

    0.upto(max_size - 1) do |index| 
      diff_count += 1 if strand[index] != other_strand[index]
    end 

    diff_count 
  end 
end 

# mine = DNA.new('GGACGGATTCTGACCTGGACTAATTTTGGGG')
# other_strand = 'AGGACGGATTCTGACCTGGACTAATTTTGGGG'

# p mine.strand.size 
# p other_strand.size 
# p mine.hamming_distance(other_strand)
