1. Closures are a general programming term referencing "chunks" of code that can be passed around and executed at a later time. Closures maintain their binding to surrounding artifacts (names for variables, methods, etc) and can access elements of their binding to expose values or make alterations. Closures are useful in that they provide flexibility in writing reusable functionality that can be utilized throughout a program. 

Closures are implemented in Ruby through: 
  - Blocks
  - `Proc` objects
  - `lambda` objects 

Each of these closures, allow for the creation of "chunks" of code that may be designed to be invoked directly or passed into other methods. 

2. Binding refers to the characteristic of closures in which access to contextual artifacts is maintained, and the closure "carries" this information around as it is passed around and executed within the program. A closure's binding offers exemption from particular scoping rules, and allows for increased flexibility in accessing variables, methods, and constants that are part of a closure's binding. 

3. Binding affects the scope of closures as closures maintain connections to artifacts that were in-scope when the closure was created. Binding allows for increased flexibility in accessing particular variables or methods from places within the program that would otherwise remain out of scope. 

4. Blocks are one way that Ruby implements closures. Blocks are "chunks" of code, that are indicated by curly braces `{block_here}` or a `do`..`end` statement. All Ruby methods can accept an implicit block, allowing for flexibility in adapting methods to a particular use case. Methods can be defined in ways that incorporate them into the functionality of the method, by *yielding* to the block as part of its implementation. 

Blocks provide a way to delegate certain decisions to users of the method at invocation time. They can be useful in designing generic methods with greater use-case flexibility. 

5. Blocks are used when: 
  - We want to move decisions about particular functionality to invocation time. 
  - We wish to give users flexible utility in using the method. 
  - Iterating through a collection and performing action on items in the collection. 

6. Examples of use cases for blocks: 
  - Delaying certain decisions about functionality to method invocation time. 
    - Demonstrated below with `Array#select` 
      - The implementation of `select` does not change.
        - `select` yields to the block and returns a new collection including only elements that returned a "truthy" value from the block.
        - By using a block, the user can utilize `select` for a wide variety of tasks without having to alter the implementation details of the method.
        - Custom behavior is offered through the block. 

  ```ruby 
  array = [1, 2, 3, 4, 5]

  # Lets say we needed to save only the odd numbers. 

  array.select { |num| num.odd? }
    # => [1, 3, 5]

  # Now lets select just the even numbers 

  array.select { |num| num.even? }
    # => [2, 4]
  ``` 

  - 

7. Every Ruby method can accept an implicit block as an argument. There is variability in the manner in which the block will be utilized based on the method implementation details, or the block may simply be ignored. 

Blocks may also be passed to methods explicitly