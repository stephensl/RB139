# Integer#times method

# def times(num) 
#   range = (0..num)

#   range.each do |num|
#     yield(num)
#   end 

#   num 
# end 

# times(5) do |num|
#   puts num 
# end 

#
#
# with explicit block 

# def times(num, &block)
#   (0..num).each do |int| 
#     block.call(int)
#   end 

#   num 
# end 

# output_num = Proc.new { |num| puts num }

# times(5, &output_num) 
# 0
# 1
# 2
# 3
# 4
# 5
# => 5 

# -------------------------------------------------------------------------

# Array#each method

# def each(arr)
#   counter = 0 

#   while counter < arr.size 
#     yield(arr[counter])
#     counter += 1
#   end 

#   arr 
# end 


# each([1, 2, 3]) { |num| puts num }


#
#
# with explicit block 

# def each(arr, &block)
#   counter = 0 

#   while counter < arr.size 
#     block.call(arr[counter])
#     counter += 1
#   end 

#   arr 
# end 

# each([1, 2, 3]) { |num| puts num }

# 1
# 2
# 3
# => [1, 2, 3]

# a_proc = Proc.new { |num| puts num + 1 }

# each([1, 2, 3], &a_proc) 

# 2
# 3
# 4
# => [1, 2, 3]


# -------------------------------------------------------------------------

# Array#select method 

# def select(arr)
#   new_array = [] 
#   counter = 0 

#   while counter < arr.size 
#     current_element = arr[counter]
#     yield(current_element) ? new_array << current_element : nil
#     counter += 1
#   end 

#   new_array 
# end 

# p select([1, 2, 3]) { |num| num.odd? }  # => [1, 3]

#
#
# with explicit block 

# def select(arr, &block)
#   results = []
#   counter = 0 

#   while counter < arr.size 
#     current_element = arr[counter]
#     results << current_element if block.call(current_element)
#     counter += 1
#   end 

#   results 
# end 

# array = [1, 2, 3, 4, 5]

# p select(array) { |num| num >= 3 }

# => [3, 4, 5]

# a_proc = Proc.new { |num| num.even? }

# p select(array, &a_proc) 

# => [2, 4]


# -------------------------------------------------------------------------


# Enumerable#reduce method 

# sets the accumulator to the return value of the block, and then passes the accumulator to the block on the next yield.

# can set accumulator to default value 

# def reduce(array, default=0)
#   counter = 0 
#   accumulator = default 

#   while counter < array.size 
#     accumulator = yield(accumulator, array[counter])
#     counter += 1
#   end 
#   accumulator
# end 


# def reduce(array, default=nil)
#   accumulator = default || array.shift
#   counter = 0

#   while counter < array.size 
#     accumulator = yield(accumulator, array[counter])
#     counter += 1
#   end 

#   accumulator 
# end 

# p reduce([[1, 2], ['a', 'b']], [10]) { |acc, value| acc + value } # => [10, 1, 2, 'a', 'b']

#
#
# with explicit block

# def reduce(coll, default=nil, &block)
#   accumulator = default || coll.shift 
#   counter = 0

#   while counter < coll.size 
#     current_element = coll[counter]
#     accumulator = block.call(accumulator, current_element)
#     counter += 1
#   end 

#   accumulator 
# end 

# p reduce([1, 2, 3]) { |acc, num| acc + num }

# # => 6

# a_proc = Proc.new { |acc, num| acc + num }

# reduce([1, 2, 3], 10, &a_proc)

# => 16 

# -------------------------------------------------------------------------

