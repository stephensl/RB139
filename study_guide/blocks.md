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

## Return value of block

Example: 
```ruby 
1 :  def compare(str)
2 :    puts "Before: #{str}" 
3 :    after = yield(str)
4 :    puts "After: #{after}" 
5 :  end 
6 :  
7 :  compare("hello") { |word| puts 'hi' }
8 :  
9 :  # Before: hello 
10:  # hi (side effect from block)
11:  # After:
12:  # => nil 
```
Execution flow of above example: 

- Invoke the `compare` method on line 7 and pass in the string `"hello"` and a block as arguments. 
- Line 1, our string argument `"hello"` is assigned to parameter `str`. `str` now references the string `"hello"`. 
- Line 2, invoke `puts` method and pass in string with method local variable `str` interpolated. This will output `Before: hello`.
- Line 3, `yield` to the block, passing `str` as argument to `yield`. 
- Line 7, block parameter `word` assigned to reference the argument passed to `yield` which is `str`, which still references the string `"hello"`. 
  - Inside the block invoke `puts` and pass in the string `"hi"` as argument. 
  - String `hi` is output to the screen
  - Block returns nil
- Line 3, local variable `after` assigned to block return value, `nil`. 
- Line 4, invoke `puts` and pass in string with local variable `after` interpolated. 
  - Outputs `After: ` because local variable `after` references `nil` and when `nil` is interpolated into a string, it evaluates to an empty string. (`nil.to_s == ''`)
- The last expression evaluated is the invocation to `puts`, which returns `nil` and is returned from `compare` method. 


## Use cases for blocks in custom methods

  1. Defer implementation detail to method invocation time.

      - Blocks allow for greater flexibility for programmers and users as method implementors are able to define generic methods that can achieve specialized behavior via the block passed in at invocation.
      - Blocks allow users to refine behavior without modifying the method implementation at all. Thus, the method maintains adaptive and flexible utility. 
      - Not using blocks limits the use of a method to the explicit implementation details defined by the method implementor, and strips the user of agency in making decisions about implementation at invocation time. 

  2. Sandwich Code: performing some "before" and "after" actions.
      - Generally implemented as: 
        - Some "before" code
        - Yield to block (the action)
        - Some "after" code
      - Example: 
      ```ruby 
      def time_it 
        time_before = Time.now 
        yield 
        time_after = Time.now 

        puts "It took #{time_after - time_before} seconds." 
      end 

      time_it { sleep(3) }  # It took 3.003767 seconds 
                            # => nil 
      ```
      - The method implementor is not concerned with what kind of action it is yielding to in the block, only that it will serve to calculate the time it took to do so. The rest is up to the method user. 


## Methods with explicit block parameter

  - Explicit block
    - block assigned to method parameter so it can be managed like any other object.
    - explicit blocks can be reassigned, passed to other methods, and invoked many times. 
    - `&` is special parameter that converts argument to a "simple" `Proc` object.

  ```ruby 
  def test(&block)
    puts "What's &block? #{block}"
  end 

  test { sleep(1) }

  # What's &block? #<Proc:0x000001e184124550
  # => nil 
  ```

  ### Why explicit blocks?
    
    - Provides additional flexibility as we now have a handle for the block and can pass it to other methods. 
    - Ruby converts blocks passed in as explicit blocks to a simple `Proc` object.

    ```ruby 
    def test2(block)
      puts "hello"
      block.call  # proc is invoked
      puts "goodbye"
    end 

    def test(&block) # test called with explicit block, converts block to simple proc. 
      puts "1"
      test2(block)   # block is a proc object now, passed to test2
      puts "2"
    end 

    test { |prefix| puts 'xyz' }
    ```

