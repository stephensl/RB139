# Blocks 
   
  ### Closures 
  - Closures in programming refers to the concept of being able to capture a segment of functionality within the code,  including references to the code artifacts that are in-scope when the closure is created. Closures may be passed around and executed numerous times within the program and may access and manipulate data referenced in the closure's binding, even if the location where the closure is executed would otherwise be out of scope for those artifacts.

  - Closures provide insight into how local variable scoping rules work in Ruby, and allow for the encapsulation and reuse of a particular functionality. Closures may be executed directly, passed as arguments to methods, returned from methods, or stored in data structues. Ruby implements closures through blocks, `Proc` objects and `lambda`s. 


  ### Binding 
  - In order for a closure to be passed around and executed later, it must maintain connection to the surrounding context from where it was defined. 

  - Binding refers to the surrounding artifacts (variables, methods, constants) that are in-scope when the closure is created and 'bound' to the closure. This allows the closure to maintain its connection to surrounding data that may be exposed or manipulated as the closure is passed around and executed within the program. A closure's binding offers increased flexibility to access particular functionality from areas within the program that would otherwise be limited by scoping rules. 

  ### Scope
  - Closures keeps track of all information needed in order to execute correctly later.
    - local variables
    - method references
    - constants
    - other artifacts needed for execution

  - Local variables must be defined *before* the closure is created in order to be accessed by the closure, unless passed in explicitly when the closure is called. 
  
  - Local variables that are part of a closure's binding, may be reassigned/updated and the closure will maintain the updated value. 

    ```ruby 
    def call_me(arg)
      arg.call 
    end 

    name = "Robert"
    
    chunk = Proc.new { puts "hi #{name}" }

    p chunk.call    # => hi Robert
    
    name = "Billy"

    p chunk.call # => hi Billy

    call_me(chunk)    # hi Billy
    ```


  ### How blocks work?

  - Blocks are anonymous segments of code, and one way that Ruby implements the concept of closures. Blocks follow a method invocation and are defined within a `do..end` or curly braces `{}`. 
  
  - All Ruby methods accept an implicit block argument, but the way in which the method either utilizes, or ignores the block is determined by implementation details of the method. 

  - The `yield` keyword is utilized in order to execute the block. 

  - Blocks have a return value, and can mutate the argument with a destructive call.






  ### Use cases for blocks

  - Defer some implementation code to method invocation time. 
    - Provides flexibility for method user to refine behavior of the method according to use case without making any changes to the method implementation. 
    - Offers increased utility through generic behavior that may be specialized at invocation time via the block. 

  - Sandwich code: before and after
    - Perform before action, yield to block, perform after action.
    - Useful in timing, logging, notification systems, resource management
    - Can offer generic behavior to support more specialized behavior provided by the block. 



  ### Blocks and variable scope


  ### Writing methods that use blocks and procs


  ### Returning closures from methods and blocks 



  ### Methods with explicit block parameter 


  ### Arguments and return values with blocks 


  ### Passing blocks to methods 


  ### Using `&` 
  - As parameter in method definition:
    - expect an explicit block and convert it into `Proc` object.
  - As prepended to argument object in method invocation: 
    - convert argument to `Proc` object, which can be passed as a block argument to the method.



  ### `&:symbol` 


  ### Arity of blocks and methods 

















# Testing 

### Terminology 


### Minitest vs RSpec


### SEAT approach 


### Assertions 










# Core Tools 

  ### Purpose of core tools 


  ### Gemfiles 





# Regex 

(cheat sheet)




# Challenge 

example algos 