# Closures
 
  ### Definition: 
 
  - A closure is a programming concept that allows a programmer to save a "chunk" of code that may be passed around and executed at a later time. 
  - Closures have a "binding" consisting of artifacts in the program such as methods and variable names that are in-scope when the closure is created. 
  - Closures retain memory of surrounding scope and can use and update variables in that scope when executed. 
  - Closures implemented through `Proc` objects, blocks, and `lambda`s . 

  ```ruby 
  def for_each_in(arr)
    arr.each { |element| yield element }
  end 

  arr = [1, 2, 3, 4, 5]
  results = [0]

  for_each_in(arr) do |number|
    total = results[-1] + number 
    results.push(total)
  end 

  p results # => [0, 1, 3, 6, 10, 15]
  ```
Though the block passed to for_each_in is invoked from inside for_each_in, the block still has access to the results array through closure.


Where closures really shine, though, is when a method or block returns a closure. 

```ruby 
def sequence
  counter = 0 
  Proc.new { counter += 1 }
end 

s1 = sequence 
p s1.call     # 1
p s1.call     # 2 

s2 = sequence 
p s2.call     # 1 
p s1.call     # 3 
p s2.call     # 2
```

The `sequence` method returns a `Proc` that forms a closure with the local variable `counter`. 

local variable `s1` is assigned to the return value of `sequence`: a `Proc`. 

We can then invoke the `Proc` multiple times, and it will increment its own private copy of `counter`. We can create multiple `Proc`s from `sequence` and each will have its own separate and independent copy of `counter`. 


---

# Blocks

In Ruby, every method takes an implicit block. How the method treats the implicit block is determined by the method implementation details. 

Blocks and Procs have lenient arity in handling arguments. 
Methods and lambdas have strict arity. 


Blocks have a return value, and can mutate the argument with a destructive call. 



### Two main use cases

  - Defer some implementation code to method invocation time. 
    - Provides flexibility for method user to refine behavior of the method according to use case without making any changes to the method implementation. 
    - Offers increased utility through generic behavior that may be specialized at invocation time based on the block. 

  - Sandwich code: before and after
    - Perform before action, yield to block, perform after action.
    - Useful in timing, logging, notification systems, resource management
    - Can offer generic behavior to support more specialized behavior provided by the block. 


### Explicit blocks 

Explicit blocks provide a way to assign a name to a "chunk" of code, in order to be able to invoke and pass the block around the program. Explicit blocks are treated as named objects, whereas implicit blocks are anonymous, and we can only yield to them.

Explicit blocks can be managed like any other object and may be reassigned,, passed to other methods, and invoked numerous times. 

Explicit blocks are defined by prepending `&` to the method parameter. 
  ```ruby 
  def test(&block)
    puts "What's &block? #{block}"
  end
  ```

The `&` converts the block argument to a simple `Proc`. 

Explicit blocks add additional flexibility as the block is treated as a named object and we can pass the block to other methods. 

  ```ruby 
  def test2(block)
    puts "hello"
    block.call         # calls the block that was originally passed to test()
    puts "good-bye"
  end 

  def test1(&block)   # &block converts to simple proc
    puts "1"
    test2(block)      # here, block is now a proc object 
    puts "2"
  end 
  ```

### More about `&`

In the context of a method definition, putting an ampersand in front of the last parameter indicates that a method may take a block and gives us a name to refer to this block within the method body

In the context of a method call, putting an ampersand in front of the last argument tells Ruby to convert this argument to a Proc if necessary and then use the object as the method’s block.


############################################################################################################

Study Guide for Test

Please be comfortable with the topics mentioned below before taking the assessment. You should be able to explain these concepts with clarity.


# Blocks
---

## Closures, binding, and scope

### Closures

**Definition**  
A closure refers to the general programming concept of saving a "chunk" of code that can be passed around within a program and executed at a later time.

**Implementation**  
Closures are implemented in Ruby through:
  - blocks
  - Instantiating objects from the `Proc` class
  - `lambda`s 

**Benefits**  
- Encapsulation of data and behavior which can be passed around and executed at a later time.
- Flexibility to pass closures around as objects and reuse them in different contexts.
- Ability to create generic methods that can be specialized at invocation time through the use of blocks.
- Ability to sandwich code before and after a block of code, which can be useful in timing, logging, notification systems, and resource management.
- Increased DRYness and modularity of code.   


### Binding 

**Definition**  
A closure's binding refers to the closure's "memory" of artifacts in the program such as local variables, method references, constants, and other artifacts that are in-scope when the closure is created. The closure will retain its binding to the surrounding scope, which allows it to access and update variables that are part of its binding when executed.
  
**Example** 
```ruby
def outer_method
  x = 10 
  yield 
end 

x = 25 

my_proc = Proc.new { puts x }

outer_method(&my_proc) # => 25
```
In the code above, the `my_proc` closure is created in the outer scope, and is bound to the variable `x` in the outer scope. When the `my_proc` closure is invoked, it will print the value of `x` in the outer scope, which is `25`.

### Scope  

**Definition**  
A closure's scope is a set of variables that are accessible to the closure and determined by its binding. A closure keeps track of its binding and retains "memory" of all necessary artifacts that enable the closure to be executed properly. 

**Rules**  
In order for a local variable to be accessed by a closure, it must be initialized prior to the creation of the closure unless the local variable is initialized within the closure itself, or passed in as an argument when the closure is executed.

**Example** 
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}" } 
name = "Griffin III"

call_me(chunk_of_code) # => hi Griffin III
```
The code above demonstrates that a closure retains access to local variables that are initialized before the closure is created, even if the local variable is reassigned after the closure is created.  

If we were to initialize the local variable `name` after the closure was created, the closure would not have access to the local variable `name` and would raise an error. 

## How blocks work, and when we want to use them.

### Blocks
**Definition**  
  - A block in Ruby is a chunk of code that can be defined using either curly braces {} or the do...end keywords. 
  - Blocks can be passed as arguments to methods, and are executed within the context of the method using the yield keyword. 
  - Blocks can also be assigned to variables using the Proc.new method or the & operator, in which case they become proc objects. 
  - Unlike procs and lambdas, blocks are not objects in Ruby and cannot be returned from methods.
  - Every method in Ruby can accept an implicit block, and the way in which the block is handled depends on the method implementation.
  - Blocks have a lenient arity and will not raise an error when the number of arguments passed to the block does not match the number of parameters defined in the block.
  - Blocks return a value, just like methods. The return value of the block is the value of the last expression evaluated in the block.

**Additional Notes: Blocks**
  - A block is *NOT* an object.
  - A block cannot be returned from a method. 
  - A `Proc` object is an object that contains a block of code. 
  - A `lambda` is a special kind of `Proc` object.

### Use Cases 
  1. When we would like to defer come implementation details to the user of the method.  

  - Generic methods can be created that offer room for more specialized behavior to be provided by the block at invocation time.  
  - Allows enhanced utility and flexibility of methods by enabling users to leverage the power of blocks to customize the behavior of the method.
  
  **Example** 

  ```ruby
  def select(arr)
    selected = [] 

    arr.each do |el|
      selected << el if yield(el)
    end

    selected 
  end 

  # The method is written in a generic way, and the block is used to 
  # provide the specific behavior that we want to use to select 
  # elements from the array.

  select([1, 2, 3, 4, 5]) { |num| num.odd? } # => [1, 3, 5]
  ```

  2. When we would like to provide some "before" and "after" structure that performs a specific task before and after the block is executed. 

  - This is useful for timing, logging, notification systems, and resource management. 
  - The method implementor is not concerned with the details of the block, but simply provides the structure that will be executed before and after the block is executed.

  **Example** 

  ```ruby
  def hello_goodbye 
    puts "hello"
    yield  # execute the implicit block
    puts "goodbye"
  end

  # The method is written generically to simply greet the user,
  # execute the block, and then say goodbye. The block is used to 
  # allow the user to provide the specific behavior that they want. 

  hello_goodbye { puts "how are you?" } # => hello
                                        # => how are you?
                                        # => goodbye
  ```

  ## Blocks and variable scope 
  - A block can access any local variable that was in scope when the block was defined, even if that variable is no longer in scope when the block is executed.
  - A block can modify the value of a local variable that was in scope when the block was defined (subject to variable shadowing rules). 
  
    
  
  
  ## Write methods that use blocks and procs
  
  - 
  
  ## Understand that methods and blocks can return chunks of code (closures)
  - Methods and blocks can both return closures that may be passed into other methods.
  
  ## Methods with an explicit block parameter
  
  
  ## Arguments and return values with blocks
  
  
  ## When can you pass a block to a method
  
  
  ## &:symbol
  
  ## Arity of blocks and methods



# Testing With Minitest

  ## Testing terminology


  ## Minitest vs. RSpec


  ## SEAT approach


  ## Assertions



# Core Tools/Packaging Code

  ## Purpose of core tools
  
  
  ## Gemfiles




# Regular Expressions




# The Coding Challenge 