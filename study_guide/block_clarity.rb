# Clearing up how blocks and `procs` are executed. 

# I am trying to refine my mental model surrounding the use of: 
  # Implicit vs Explicit 
  # Passing procs to methods 
  # Calling procs in methods
  # Calling blocks in methods 
  # The use of `&` operator 

# 
#
#

# Yielding to an implicit block 

# def add_ten_to_each(collection)
#   collection.each { |num| yield(num) }
# end 

# arr = [1, 2, 3]

# add_ten_to_each(arr) do |num|
#   puts num + 10 
# end 

# 11
# 12 
# 13
# => nil 

# In this example, we define a method `add_ten_to_each` which takes one argument, a collection. 

# On line 20, initialize an `Array` object to be referenced by local variable `arr`.

# Line 22, invoke `add_ten_to_each` and pass in `arr` and a block as arguments. 

# Line 16, method parameter `collection` is assigned to local variable `arr`, and now references the array object initialized on line 20. 

# Line 17, invoke the `each` method on method local variable `collection` and pass each element into the block. 

# Inside the block on line 17, the first element `1` is assigned to block parameter `num`. `num` is yielded to the passed in block.

# Line 22, block parameter `num` is assigned to reference `num` from within the method. Now references `1`.

# Line 23, invoke `puts` method and pass in `num` + 10 as an argument. This outputs 11, and returns nil. 

# Line 17, back into the method, the second element is now passed into the block to be yielded and the process repeats. 

# The method outputs 11, 12, 13 each on its own line, and returns nil as the last expression evaluated is `puts`, which returns nil. 

# 
#
#
#


# Explicit blocks

  # `&` in method parameter indicates an explicit block. 

  # Ruby converts block passed in explicitly to a simple `Proc` object.

  # Explicit blocks are used in order to provide additional flexibility to pass the block as a named object. Implicit blocks are unnamed, and can only be yielded to, whereas explicit blocks have a handle that we can pass around in the program. 


# def test(&block) # block converted to simple proc 
#   test2(block)   # block is now a proc 
# end 

# def test2(block)
#   block.call     # calling simple proc 
# end 

# name = "Billy"
# test { puts "How are you #{name}?" }

# # => How are you Billy?


#
#
#
#


# Passing in a proc 

# def give_me(a_proc)
#   a_proc.call
# end 

# my_proc = Proc.new { puts "Here's the proc" }

# give_me(my_proc) 

# Here's the proc
# => nil 



# 
#
#
#

# Symbol to proc 

# def make_all_upcase(collection)
#   collection.each do |element|
#     yield(element)
#   end 
# end 

# arr = %w(the cat is funny)

# p make_all_upcase(arr, &:upcase!)

# => ["THE", "CAT", "IS", "FUNNY"]

# Line 116, invoke method and pass in arr and &symbol. 

# &:upcase! 
  # ruby checks to see if it is a proc
  # it is not, so ruby calls `Symbol#to_proc`
  # ruby then converts proc to block
    # &:upcase! becomes { |n| n.upcase! }

#
#

# Playing around with previous example

def make_all_upcase(collection, a_proc)
  collection.each do |element|
    a_proc.call(element)
  end 
end 

arr = %w(the cat is funny)
my_proc = :upcase!.to_proc 

p make_all_upcase(arr, my_proc)

# => ["THE", "CAT", "IS", "FUNNY"]