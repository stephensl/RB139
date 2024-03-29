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

# def make_all_upcase(collection, a_proc)
#   collection.each do |element|
#     a_proc.call(element)
#   end 
# end 

# arr = %w(the cat is funny)
# my_proc = :upcase!.to_proc 

# p make_all_upcase(arr, my_proc)

# # => ["THE", "CAT", "IS", "FUNNY"]

#
#
#
#
#


#### The unary `&` ####


# In method definition: 
  # - expects to be passed a block, which it converts to a proc

# def select(collection, &block)
#   selected = []

#   collection.each do |element|
#     p block  # outputs proc object 
#     if block.call(element)
#       selected << element 
#     end 
#   end 

#   selected 
# end 

# p select([1, 2, 3]) { |num| num.odd? }

# => 
#<Proc:0x00000001033fc268 block_clarity.rb:171>
#<Proc:0x00000001033fc268 block_clarity.rb:171>
#<Proc:0x00000001033fc268 block_clarity.rb:171>
# [1, 3]

# 
#
#

# In method invocation:
  # - expects a proc, which is converted to a block
  # - this block is passed in to the called method

  # - if is non-proc object:
  # - ruby calls `#to_proc` and the resulting proc is converted into a block by `&`

  # def select(collection, proc)
  #   selected = []

  #   collection.each do |element|
  #     p proc
  #     if proc.call(element)
  #       selected << element 
  #     end 
  #   end 
  #   selected 
  # end 

  # a_proc = Proc.new { |num| num.odd? }
  
  # p select([1, 2, 3], a_proc)





  # or 




  # def select(collection)
  #   selected = []

  #   collection.each do |element|
  #     if yield(element)
  #       selected << element 
  #     end 
  #   end 
  #   selected 
  # end 

  # a_proc = Proc.new { |num| num.odd? }
  
  # p select([1, 2, 3], &a_proc)



  #
  #
  #
  #

  # &block means something different in the method implementation (converts the optionally passed in block into a Proc object unless it is already a Proc object) than in the method invocation (converts a Proc object into a block).

def yield_to_explicit_block(&block)
  block.call 
end

proc = Proc.new { puts 'hello' }

yield_to_explicit_block(&proc)



& in method invocation vs in method definition as parameter.

vs & in &:to_s






def yielder(a_proc)
  yield(a_proc)
  a_proc.call 
end 

my_proc = Proc.new { puts "Hello World!"}

yielder(my_proc) { |proco| puts "#{proco.call} and goodnight" } 

# #<Proc:0x00000001063993b8 sand.rb:18>
# Hello World!


# To summarize, the & operator in the method parameter is used to provide a handle to the block within the method, represented as a Proc object. The yield keyword executes the block directly, not the Proc object. The block is still accessible within the method's scope even if it has been bound to a Proc object through the explicit block parameter.



# def method_a
#   Proc.new { |x| x + 2 }
# end 

# def map(arr)
#   fresh_arr = []

#   arr.each do |num|
#     ret_val = yield(num) if block_given?
#     fresh_arr << ret_val 
#   end 

#   fresh_arr 
# end 

# p map([1,2,3], &method_a)

# The & prepended to method_a, Ruby will convert the Proc object returned by method_a to a block, and then pass it in as an argument to the map method. If so, the Proc is passed into the method to be executed according to method implementation. If the reference following the & is NOT already a Proc object, Ruby will attempt to call #to_proc on it in order to convert it to a Proc. 

# If the object has a to_proc method defined for its class, the object will be converted to a Proc and passed into the method. If the object's class does not implement a to_proc method, an error will be thrown for MethodError: to_proc

# When using yield, you cannot directly access the block as an object, which can limit some flexibility compared to using the &block parameter.

# Handle to reference and manipulate the block object within the method. This approach can offer greater flexibility compared to using yield. Some benefits and use cases of having a handle to the block object include:

#     You can call the block multiple times within the method, if needed, which might not be semantically clear when using yield multiple times.
#     You can pass the block as an argument to another method or function.
#     You can store the block for later use, for example, in a data structure or instance variable.
#     You can inspect the block's properties, like its arity (number of arguments it takes) using the block.arity method.