Palindrome Checker
Write a method called palindrome? that takes a string as an argument and returns true if the string is a palindrome and false otherwise. A palindrome is a word, phrase, number, or other sequences of characters that reads the same forward and backward (ignoring spaces, punctuation, and capitalization).

Prime Numbers
Create a method called prime? that takes an integer as an argument and returns true if the given number is a prime number and false otherwise. A prime number is a number greater than 1 that cannot be formed by multiplying two smaller natural numbers.

Fibonacci Sequence
Write a method called fibonacci that takes an integer n as an argument and returns the nth value in the Fibonacci sequence. The Fibonacci sequence is a series of numbers in which each number is the sum of the two preceding ones, starting from 0 and 1.

Caesar Cipher
Implement a method called caesar_cipher that takes a string and a number shift as arguments and returns the Caesar cipher of the given string with the given shift value. The Caesar cipher is a simple encryption technique that shifts each letter in the plaintext by a fixed number of positions down the alphabet.

Longest Substring
Write a method called longest_substring that takes a string as an argument and returns the longest substring without repeating characters.

String Compression
Implement a method called compress that takes a string as an argument and returns a new string with a basic compression applied. The compression should replace consecutive repeated characters with the character followed by the count of repetitions. If the compressed string would not become smaller than the original string, the method should return the original string.

Integer to Roman
Write a method called integer_to_roman that takes an integer as an argument and returns the Roman numeral representation of the given integer. The integer will be between 1 and 3999.

Missing Number
Create a method called missing_number that takes an array of integers as an argument and returns the missing number in the given range. The array will have no duplicates and contain integers from 1 to n, with one missing number.

Two Sum
Write a method called two_sum that takes an array of integers and a target integer as arguments and returns an array of indices of the two numbers in the input array such that they add up to the target. Assume that each input has exactly one solution, and you may not use the same element twice.

Word Frequency
Implement a method called word_frequency that takes a string as an argument and returns a hash with each unique word in the string as keys and the number of times they appear in the string as values. Ignore capitalization and punctuation.


Blocks
a. Describe the purpose of blocks in Ruby. (Open-ended)
b. Choose the correct difference between the do..end and {} syntaxes for blocks. (Multiple choice)
i. do..end has a higher precedence than {}
ii. {} has a higher precedence than do..end
iii. do..end and {} have the same precedence

Closures, binding, and scope
a. Define closures in the context of Ruby programming. (Open-ended)
b. Explain the difference between local and global scope in Ruby. (Open-ended)

How blocks work and when to use them
a. Write a method that takes a block and demonstrates how to call the block within the method. (Code snippet)

Blocks and variable scope
a. Explain how variables are scoped within a block. (Open-ended)

Write methods that use blocks and procs
a. Write a method that takes a proc as an argument and demonstrates how to call the proc within the method. (Code snippet)

Understand that methods and blocks can return chunks of code (closures)
a. Provide an example of a method that returns a closure. (Code snippet)

Methods with an explicit block parameter
a. Explain the benefits of using an explicit block parameter in a method. (Open-ended)

Arguments and return values with blocks
a. Write a method that takes a block as an argument and returns the result of the block. (Code snippet)

When can you pass a block to a method?
a. Given the following code snippet, determine whether it is possible to pass a block to the method. If so, demonstrate how. If not, explain why not. (Code snippet and open-ended)
ruby
Copy code
def example_method(arg1, arg2)
  arg1 + arg2
end
&:symbol
a. Explain the purpose of the &:symbol syntax in Ruby. (Open-ended)
b. Refactor the following code snippet to use the &:symbol syntax. (Code snippet)
ruby
Copy code
["hello", "world"].map { |word| word.capitalize }
Arity of blocks and methods
a. Define "arity" in the context of Ruby programming. (Open-ended)
b. Given the following code snippet, determine the arity of the block and the method. (Code snippet)
ruby
Copy code
def example_method(arg1, &block)
  block.call(arg1)
end

example_method(5) { |num| num * 2 }
Testing with Minitest
a. Explain the purpose of Minitest in Ruby. (Open-ended)
b. Write a simple test case using Minitest for the following method. (Code snippet)
ruby
Copy code
def square(num)
  num * num
end
Testing terminology
a. Define the following testing terms: (Open-ended)
i. Assertion
ii. Test suite
iii. Test case

Minitest vs. RSpec
a. Compare Minitest and RSpec in terms of their usage, syntax, and community preference. (Open-ended)

SEAT approach
a. Explain the SEAT approach to testing. (Open-ended)

Assertions
a. List three common assertions used in Minitest. (Open-ended)

Core Tools/Packaging Code
a. Explain the purpose of core tools in Ruby. (Open-ended)

Gemfiles
a. Describe the purpose and structure of a Gemfile. (Open-ended)

Regular Expressions
a. Write a regular expression that matches a valid email address. (Code snippet)

Precision of Language
a. Given the following code snippet, provide a precise explanation of what the method does. (Code snippet and open-ended)

ruby
Copy code
def greet(name)
  puts "Hello, #{name}!"
end