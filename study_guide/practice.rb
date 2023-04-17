# 1. A closure is a general programming concept that describes saving a "chunk" of code and passing it around to be executed throughout the program. Closures are useful in that they act like anonymous methods, and can be passed around as arguments to other methods. Clsoures maintain their "memory" of the context/environment within which they were created, and can access code artifacts such as local variables, method references, constants, etc. that were in scope at the time the closure was defined. In Ruby, closures are implemented through blocks, `Proc` objects, and `lambda`s. Closures retain access to the variables, constants, and methods that were in scope at the time of their creation, even if those variables, constants, or methods are no longer in scope when the closure is executed.

# 2. Variable scope in Ruby is determined where within the program the variable is initialized, and the code constructs surrounding the variable. Typically, local variable scoping rules allow for variables initialized in the outer scope to be available within the inner scope of blocks, but local variables initialized within a block are inacessible outside of the block. Closures are at the heart of variable scoping rules in Ruby and allow us to access variables in areas of the program that would otherwise render them out of scope. A closure's binding allows us to access and manipulate variables that were in scope when the closure was created, and allows for increased flexibility throughout the program. 

# 3. Blocks in Ruby are defined by either curly braces {} or do..end statement. Any Ruby method can take an implicit block, and the way in which the block is utilized is determined by the implementation details of the method. 

def method_with_block 
  yield 
end 

method_with_block { puts "Hello from the block!" }

# In the example above, the method `method_with_block` takes an implicit block, and the block is executed by calling the `yield` keyword. The `yield` keyword is a Ruby keyword that executes the block that was passed to the method.

# 4. A `Proc` object is a Ruby object that is used to store a block of code. A `Proc` object can be passed around as an argument to other methods, and can be executed by calling the `call` method on the `Proc` object.`Proc` objects differ from blocks in that they are objects, and can be stored in variables, passed to other methods, and returned from methods. 

proc_example = Proc.new { |x, y| puts x + y }

result = proc_example.call(1, 2)
puts result 

# 3 

# We can pass the `Proc` into a method by passing it as an argument.

def method_with_proc(proc)
  proc.call 
end

method_with_proc(proc_example) # => 3

# We can also pass it to the method as a block by using the `&` operator to convert the `Proc` object into a block.

def method_with_proc(&proc)
  proc.call 
end 

method_with_proc(&proc_example) # => 3

# We include the `&` operator when passing a `Proc` object as a block to a method because the `&` operator converts the `Proc` object into a block. 


# 5. A `lambda` is a Ruby object that is used to store a block of code. A `lambda` is similar to a `Proc` object in that it can be passed around as an argument to other methods, and can be executed by calling the `call` method on the `lambda`. `lambda`s differ from `Proc` objects in that they are more strict about the number of arguments that they accept. `lambda`s also return from the calling method when they are executed, whereas `Proc` objects do not.

# 6. 

