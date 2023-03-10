# Blocks
---
---

## Key Points
  - Every Ruby method accepts an optional block as an implicit argument.
  - Implementation details of the method determine how block is utilized.
  - A block is passed to a method as an argument and is *NOT* part of method implementation.


## Yielding 

The `yield` keyword allows us to invoke the passed-in block argument from within the method. 

  - If a method is defined to include a `yield` keyword: 
    - Will produce `LocalJumpError` if no block passed to the method. 
    - Can use the `Kernel#block_given?` method to conditionally `yield` to the block. 

## Yielding with Argument 

  - More arguments than block parameters: 
    ```ruby 
    def test
      yield(1, 2) # pass 2 block arguments
    end 

    test { |num| puts num } # expecting 1 parameter in block implementation

    # 1
    # => nil 
    ```
    In this example, the block passed in to the `test` method at invocation expects one parameter, but the `test` method is defined to pass two arguments to the block via `yield`. The method outputs `1` and returns `nil`. The second argument to the block is simply ignored, as the block accepts just the first argument (1), and outputs it as expected from the block without generating an ArgumentError. 

  - Less arguments than block parameters:
    ```ruby 
    def test
      yield(1)
    end 

    test { |num1, num2| puts "#{num1} #{num2}" }

    # 1 
    # => nil
    ```
    This example will output `1` followed by an empty space, and return `nil`. The second parameter `num2` is unused, and thus evaluates to `nil`. When `nil` is interpolated following the call to `puts` inside the block, an empty space is output, while the first argument to the block works as expected without throwing an error. 


## Arity 
Arity references the rules regarding the number of arguments that must be passed to a block, `proc`, or `lambda`. 

  - **Lenient Arity**: do not enforce argument count if less or more than expected. 
    - Blocks
    - `Proc`s

  - **Strict Arity**: must pass exact number of arguments expected. 
    - Methods
    - `lambda`s


