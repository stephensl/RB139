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



