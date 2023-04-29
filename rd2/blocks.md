
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

  ### Scope: 
    - Closures allow for access and modification to data referenced by variables that are part of its binding from areas of the code that would otherwise be out of scope. 






# How blocks work, and when we want to use them.

  ## Blocks

  ### Definition: 
    - Blocks are "chunks" of functionality that are used as anonymous pieces of code that may be passed around and executed. Blocks may be passed implicitly as arguments to any Ruby method, and the way in which the block is handled is dependent on the implementation details of the method. 
    - Blocks are defined using either `do..end` or curly braces `{}` following a method invocation. 
    - In order to execute a implicit block argument within a method, we utilize the `yield` keyword. 
    - Blocks are not objects, and therefore cannot be assigned to variables or returned from methods. However, blocks may be converted into `Proc` objects, allowing for additional flexibility such as the ability to be assigned to variables, reassigned, or returned from methods. 

  ### Use Cases: 
    - Deferring some implementation details to method invocation time, rather than hardcoding them into the method definition. 
      - This allows programmers to define generic methods that may be customized for a particular use-case at invocation time by the method user. 
      - Allows for enhanced utility across a wide variety of use-cases that may be unknown to the implementer. 
      - Allows for greater code reusability, and flexibility without having to re-define methods for each use case. 
    - Sandwich code: providing the structure of a "before" action, yielding execution to the block, then providing some "after" action. 
      - Useful in: 
        - Timing how long it takes to execute certain functionality defined in the block. 
        - Managing resources: automatically opening and closing relevant files. 


# Blocks and variable scope

## 


# Write methods that use blocks and procs


# Understand that methods and blocks can return chunks of code (closures)


# Methods with an explicit block parameter


# Arguments and return values with blocks


# When can you pass a block to a method


# &:symbol


# Arity of blocks and methods
