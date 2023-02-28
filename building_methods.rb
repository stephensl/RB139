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

# -------------------------------------------------------------------------

