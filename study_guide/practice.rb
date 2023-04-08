=begin
In this kata, you have an input string and you should check whether it is a valid message. To decide that, you need to split the string by the numbers, and then compare the numbers with the number of characters in the following substring.

For example "3hey5hello2hi" should be split into 3, hey, 5, hello, 2, hi and the function should return true, because "hey" is 3 characters, "hello" is 5, and "hi" is 2; as the numbers and the character counts match, the result is true.

Notes:

Messages are composed of only letters and digits
Numbers may have multiple digits: e.g. "4code13hellocodewars" is a valid message
Every number must match the number of character in the following substring, otherwise the message is invalid: e.g. "hello5" and "2hi2" are invalid
If the message is an empty string, you should return true

p (valid?("3hey5hello2hi") == true
p (valid?("4code13hellocodewars") == true
p (valid?("3hey5hello2hi5") == false
p (valid?("code4hello5") == false
p (valid?("1a2bb3ccc4dddd5eeeee") == true
p (valid?("") == true

P: 

This problem asks for us to split a string by numbers and compare the numbers with the number of characters in the following substring.

Example: 

"3hey5hello2hi" would split 

: after the last number in a substring of numbers 0-9, and 
: after the last letter in a substring before either 
  : a space, 
  : number, or 
  : the end of the string.. 

  [3, hey, 5, hello, 2, hi]

  
Requirements:

Return true if: 

  : if the string is empty


  : string must start with a number &&
  : string must end with a letter &&
  : string must have equal number of letters and numbers.

  : Return false if: 

    : string starts with a letter
    : string ends with a number
    : string has unequal number of letters and numbers
    : string has a number that is not followed by a letter

Regex should: 

: may match a number of any length,
: split after the last number in substring.
: 1 or more letters followed by a number or end of string
: repeat pattern 
: end of string must be a-z character

=end 


def valid?(string)
  return true if string.empty?
  return false if string.chars.last.match(/[0-9]+/)

  nums = string.scan(/\d+/)
  letters = string.scan(/[a-z]+/)

  zipped = nums.zip(letters).each do |num, letter|
    return false if num.nil? || letter.nil? || num.to_i != letter.size
  end

  true
end




p valid?("3hey5hello2hi") == true
p valid?("4code13hellocodewars") == true
p valid?("3hey5hello2hi5") == false
p valid?("code4hello5") == false
p valid?("1a2bb3ccc4dddd5eeeee") == true
p valid?("") == true