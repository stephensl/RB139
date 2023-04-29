
# Closures, binding, and scope

  ## Closures

  ### Definition: 
    - The concept of closures in programming allows for a segment of functionality to be captured, along with its surrounding context, and passed around within the program to be executed at another time. Closures are essentially a functional snapshot of a "chunk" of code that the programmer can re-use, pass into methods, and execute numerous times. Closures retain their memory of the various artifacts within the code such as variable names, method references, constants, etc. that are in-scope when the closure is created and become part of the closure's binding. Closures enable access and modification of data referenced by variables within the closure's binding throughout the program.

  ### Benefits:
    - Encapsulation: closures encapsulate the state and implementation details of a particular "chunk" of functionality. 
    - DRY code: closures may be created in a specific context, and then reused throughout the program. 
    - Flexibility: closures may be passed as arguments to other methods, and may also be returned by methods. 

  ### Binding: 
    - A closure's binding is comprised of the various code artifacts such as variable names, references to methods, constants, etc. that are in-scope at the time the closure is created. 
    - A closure retains its binding as it is passed around and executed throughout the program, allowing for access and modification of data referenced in the closure's binding from areas of the program that would otherwise render them out of scope.
    - A closure retains its reference to variables that are part of its binding, and includes all necessary information in order to properly execute it later. 

  ### Scope: 
    - Closures allow for access and modification to data referenced by variables that are part of its binding from areas of the code that would otherwise be out of scope. 
    - Closures seemingly do not adhere to local variable scoping rules, but may access and modify data that is part of its binding even when executed in a context within which those data would otherwise not be accessible.






# How blocks work, and when we want to use them.

  ## Blocks

  ### Definition: 
    - Blocks are "chunks" of functionality that are used as anonymous pieces of code that may be passed around and executed. Blocks may be passed implicitly as arguments to any Ruby method, and the way in which the block is handled is dependent on the implementation details of the method. 
    - Blocks are defined using either `do..end` or curly braces `{}` following a method invocation. 
    - In order to execute a implicit block argument within a method, we utilize the `yield` keyword. 
    - Blocks are not objects, and therefore cannot be assigned to variables or returned from methods. However, blocks may be converted into `Proc` objects, allowing for additional flexibility such as the ability to be assigned to variables, reassigned, or returned from methods. 

  ### Use Cases: 
    - Deferring some implementation details to method invocation time, rather than hardcoding them into the method definition. 
      - This allows programmers to define generic methods that may be customized and refined for a particular use-case at invocation time by the method user. 
      - Allows for enhanced utility across a wide variety of use-cases that may be unknown to the implementer. 
      - Allows for greater code reusability, and flexibility without having to re-define or alter methods for each use case. 
    - Sandwich code: providing the structure of a "before" action, yielding execution to the block, then providing some "after" action. 
      - Useful in: 
        - Timing how long it takes to execute certain functionality defined in the block. 
        - Managing resources: automatically opening and closing relevant files. 
        - Logging data and notification systems. 


# Blocks and variable scope

## Closures retain memory of their surrounding scope, and may access and update variables within that scope when they are executed, even if executed in a different scope. 

  - Example: 
  ```ruby 
  def for_each_in(arr)
    arr.each { |element| yield(element) }
  end 

  arr = [1, 2, 3, 4, 5]
  results = [0]

  for_each_in(arr) do |number|
    total = results[-1] + number 
    results << total 
  end 

  p results
  ```

  In this code:
   - We invoke the `for_each_in` method and pass in local variable `arr`, and a block as an argument. 
   - Upon invocation, method parameter `arr` is assigned to reference the array object passed in as an argument `[1, 2, 3, 4, 5]`. 
   - In the body of the method, we invoke the `Array#each` method and pass in a block as an argument. 
   - `Array#each` will iterate through the array assigned to method local variable `arr`, and pass each element into the block, assigning the current element to block parameter `element`. 
   - We then utilize the `yield` with `element` as an argument to yield execution to the block passed in as an argument to `for_each_in`. 
     - Within the block, `element` is assigned to block parameter `number`, and is added to the value at `results[-1]` and then assigned to block local variable `total`. 
     - `total` is appended to the `results` array within the block, that is available via closure, as `results` was initialized and in-scope at the time the closure was created (at method invocation time).
   - We then return to the `for_each_in` method, and the next element is is assigned to block parameter `element` and passed in as an argument to `yield` within the block argument to `Array#each`. 
    - Repeat until iteration complete. 

  - We invoke the `p` method and pass in local variable `results` as an argument. This will output the array referenced by `results`, which has been modified within the block passed in as an argument to `for_each_in` at method invocation time. 
    - The return value of `for_each_in` is the original collection, `[1, 2, 3, 4, 5]`
    - The return value of `p results` is the mutated array referenced by local variable `results`, `[0, 1, 3, 6, 10, 15]`

  - Here we see that we are able to see that the block passed to `for_each_in`, while invoked from inside the `for_each_in` method, still has access to the `results` array via closure, as it is part of the closure's binding. 



# Write methods that use blocks and procs

## `yield` keyword: 
  - Invokes the passed-in block argument
  - "yields" execution to the block

### `yield` with arguments:
  - May pass arguments to `yield` in order to provide arguments to the block. 
  - Block itself is an argument to the method. 
  - Blocks have lenient *arity* meaning that Ruby will not throw an error if too many, or too few arguments are passed to a block. 
    - Missing or additional arguments/parameters will evaluate to `nil`.
  
  - Example: 
      ```ruby 
      def map(arr)
        new_arr = []

        arr.each do |element|
          new_arr << yield(element)  # argument to block
        end 

        new_arr
      end 

      p map([1, 2, 3]) { |num| num**2 }

      # => [1, 4, 9]
      ```

  - Example with wrong number of arguments to block: 
    ```ruby 
    def map(arr)
      new_arr = []
      x = 5

      arr.each do |element|
        new_arr << yield(element, x) # extra arg to block
      end 

      new_arr 
    end 

    p map([1, 2, 3]) { |num| num**2 }

    # => [1, 4, 9]  extra arg ignored due to lenient arity
    ```

  - Example with wrong number of block parameters: 
    ```ruby 
    def map(arr)
      new_arr = []

      arr.each do |element|
        new_arr << yield(element) 
      end 

      new_arr 
    end 

    map([1, 2, 3]) { |num, x| puts "#{num**2} and x is: #{x.inspect}" }
      # extra block parameter "x" is ignored. 

    #  1 and x is: nil
    #  4 and x is: nil
    #  9 and x is: nil
    ```

# Understand that methods and blocks can return chunks of code (closures)
  
  ## Methods returning closures:
  - The return value of a method may be a closure in the form of a `Proc` or `lambda`. 
  - Example: 
    ```ruby 
    def a_method
      Proc.new { |x| x + 1 }
    end 

    closure = a_method  # return value assigned to local var `closure`

    p closure # #<Proc:0x00000001068d4cd8 r.rb:2>

    p closure.call(3) # 4 

    def another(num, a_proc)  
      a_proc.call(num)
    end 

    another(3, closure) # 4 Proc passed as arg to `another` method.
    ```

  - LS Example: 
    ```ruby 
    def sequence 
      counter = 0 
      Proc.new { counter += 1 }
    end 

    s1 = sequence
    # return value (Proc obj) assigned to s1 with own copy of local variable `counter` via closure.
    
    p s1.call # 1
    # We execute the `Proc` assigned to s1, which returns the value of `counter += 1`. 
    p s1.call # 2
    # We can invoke the `Proc` numerous times, and it retains its binding to `counter` which was in scope when the closure was created. 

    s2 = sequence 
    # This creates a new closure and assigns the returned `Proc` object to s2. 
    # The `Proc` assigned to s2 has its own copy of `counter` as part of its binding. 
    s2.call # 1
    s1.call # 3
    ```

  ## Blocks returning closures:
    ```ruby 
    def capture_block
      yield
    end

    my_proc = capture_block do
      factor = 3
      Proc.new { |x| x * factor }
    end

    puts my_proc.call(5) # Output: 15
    ``` 
    In this example, we define a method `capture_block` that simply yields execution to the block. 

    We invoke `capture_block` and pass in a block as an argument. 

    `capture_block` then yields to the block passed in as an argument. 

    The return value of the block, is a `Proc` object, with `factor` as part of its binding. 

    The the return value of the block, is returned to the `capture_block` method, and because it is the last expression evaluated in the method, the `Proc` is returned. 

    The `Proc` object is returned by both the block, and the `capture_block` method. 


# Methods with an explicit block parameter

## What are explicit blocks?
  - All Ruby methods can take an implicit block argument, the way in which it utilizes or ignores the block is determined by implementation details of the method. 
  - We can define methods to take an explicit block, which provides increased flexibility as the block is assigned to a named method parameter, and can be treated like any other Ruby object in terms of assignment, reassignment, passage into methods, and ability to invoke it numerous times. 

### Defining explicit block arguments:
  - To define a method in a way that takes an explicit block, we prepend the parameter with the unary `&`.
    - The unary `&` operator is used to convert the block into a "simple" `Proc` object which can be passed around and invoked later. 
    - The `&` tells Ruby to capture any block passed into the method as a `Proc` object and assign it to that parameter. 
  - `Proc` objects serve as a wrapper for the block that allow it to behave as a named Ruby object, rather than an anonymous function. 
    - May be assigned to a variable, passed as an argument to other methods, or returned from a method. 

  - Example: defining method to take explicit block.
    ```ruby 
    def some_method(&block)
      block.call     # invoke `Proc` object
    end 

    some_method { puts "hello" }

    # hello 
    # => nil 
    ``` 
      - `some_method` above is defined with one parameter, an explicit block. 
      - The `&` operator tells Ruby that any block passed into the method at invocation time should be captured in a `Proc` object assigned to `block`. 
      - We invoke `some_method` and pass in a block argument. 
      - The block `{ puts "hello" }` is converted to a `Proc` object assigned to method parameter `block`. 
      - Within `some_method` the `Proc` is invoked, which outputs the string `hello` and returns `nil`. 

    - Example: We can also pass the explicit block to another method.
      ```ruby 
      def some_method(&block)
        other_method(block)
      end 

      def other_method(a_proc) 
        a_proc.call 
      end 

      x = 10 
      some_method { puts "hello and x is: #{x}." }

      # hello and x is: 10
      # => nil 
      ``` 
    - Arguments may be passed to explicit block as arguments to `#call`. 


# Arguments and return values with blocks
  - Blocks can return a value or mutate the argument just like methods. 
    - Without an explicit `return`, the return value is the last expression evaluated in the block. 


# When can you pass a block to a method

  - Any Ruby method can take an implicit block as an argument. 
  - Ruby methods may be defined to accept explicit blocks by prepending the final parameter with the `&` operator, which tells Ruby that a block passed into the method at invocation time should be assigned to the parameter name following the `&` as a `Proc` object. 


# &:symbol
  - Useful shortcut when working with collections.

  ## Example in iterative methods: 

    ```ruby 
    [1, 2, 3].map(&:to_s)

    # => ["1", "2", "3"]
    ```

  - The `&` must be followed by a symbol name for a method that can be invoked on each element in the collection. 
  - Works with any collection method that takes a block. 
  - CANNOT use for methods that take arguments. 

  ### How `Symbol#to_proc` works:
  
  This code: 
    ```ruby 
    &:to_s
    ``` 
  
  is converted to...

  ```ruby 
  { |n| n.to_s }
  ```

  - We are applying the `&` to an object (which may be referenced by a variable). 
    - Ruby then tries to convert the object to a block.
      - If object is already a `Proc` happens naturally. 
      - If NOT, must first convert to `Proc` object by calling `to_proc` on the object, which returns a `Proc` that Ruby then converts to a block. 

  - Example from above: 
    - `&:to_s` tells Ruby to convert the Symbol `:to_s` to a block.
    - `:to_s` is not a `Proc` so `Symbol#to_proc` is called. 
    - Now it is a `Proc` which Ruby converts to a block. 

  - Other examples: 
    ```ruby 
    def my_method 
      yield(2)
    end 

    my_method(&:to_s)   

    # functionally same as: 

    my_method { |n| n.to_s }
    ``` 

    Broken down into two steps: 

    ```ruby 
    def my_method
      yield(2)
    end 

    a_proc = :to_s.to_proc
    my_method(&a_proc) 
    # & in method invocation tells ruby to treat it as an implicit block argument to my_method. 


    


# Arity of blocks and methods
  - Lenient for blocks and strict for methods.
