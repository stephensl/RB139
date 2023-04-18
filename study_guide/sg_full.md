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
  - 
  
  
  ## Write methods that use blocks and procs
  - Every method in Ruby takes an implicit block, which is utilized according to method implementation details.
  - Use `yield` keyword to yield control to the block. 
  - Blocks may be passed into methods implicitly or explicitly with an explicit block parameter. 
  
  ## Understand that methods and blocks can return chunks of code (closures)
  - Methods and blocks can both return closures that may be passed into other methods.
  
  ## Methods with an explicit block parameter
  - A block may be passed to a method as an explicit block parameter where the block is treated as a named object. 
  - May be passed around, reassigned, invoked multiple times, and manipulated in ways unavailable for implicit blocks.
  - Achieved through converting block argument to proc. 

    - Converting block to Proc
      - Add parameter prepended with unary `&` as last parameter in method definition.
      - This saves the block passed to method as a `Proc` object, which can be referenced and passed around as named object.
      - To reference inside method, call the parameter (variable) without the `&`
      - To execute the `Proc`, invoke the `Proc#call` method on it. 
  
  
  ## Arguments and return values with blocks
    - Arguments may be passed to closures by passing an argument to `yield` or `call`. 
    - The return value of the block is the final expression evaluated.

  ### Yielding with an argument 
    - In order to yield with an argument: 
    - Add an argument to `yield` statement. 
      - `yield(argument)`
    - Define with block with a block parameter.
      - `{ |block_param| # code }`
      - Block parameter is also called "block local variable" and scope is constrained to the block. 
        - Important to use unique name to prevent local variable shadowing. 
  
  ### Return values
    - Just as methods should either return a meaningful value or perform some kind of side-effect action (output, mutate), blocks should do the same. 
    - Return value from block can be captured in local variable, utilized by the method, or ignored depending on implementation details. 


  ## When can you pass a block to a method
    If you want to do anything in your method with a block other than execute it with `yield`, then you really want a `Proc`. We create a `Proc` by calling a method with an explicit block parameter (`&parameter`). Now the block has been converted into an object that can be referenced and passed around. There is really no other way to convert a block to a `Proc` because the only place that blocks exist are in method invocations.

  
  
  ## &:symbol
    - Using `&:symbol` tells Ruby to convert the `Symbol` to a block. 
    - If symbol is already a `Proc` then Ruby can easily convert it to a block.
    - If symbol is not a `Proc`, Ruby will attempt to convert it to a `Proc` by calling `to_proc` on it.
    - If `to_proc` is not defined, Ruby will raise an error.
    - Now that it is a `Proc` Ruby can convert it to a block.

    ```ruby 
    def my_method
      yield(2)
    end

    my_method(&:to_s) # => "2"
    ```

    This is the same as: 

    ```ruby 
    def my_method
      yield(2)
    end

    a_proc = :to_s.to_proc          # explicitly call to_proc on the symbol
    my_method(&a_proc)              # convert Proc into block, then pass block in. Returns "2"
    ```

    - `&:to_s` is converted to a block, which is then passed to `my_method`.
    - `&:to_s` is converted to `{ |num| num.to_s }`

    
  
  ## Arity of blocks and methods

  Arity describes the number of required arguments for a method or block. Blocks and `Proc` objects are demonstrate lenient arity rules, and will not raise an error if the wrong number of arguments are passed to them. If extra arguments are passed to a block or `Proc`, they are ignored. If too few arguments are passed to a block or `Proc`, the missing arguments are set to `nil`. 

  Methods and `lambda`s have strict arity rules, and will raise an error if the wrong number of arguments are passed to them. 




# Testing With Minitest

MiniTest is a testing framework that is included in the Ruby standard library. It is a bundled gem shipped with default Ruby installation. We use it primarily for regression testing, which is testing that our code still works after making changes to it.


  ## Testing terminology

  Test suite: A collection of tests that are grouped together and run together. Test suite includes all tests for a particular project. 

  Test: A certain situation or context in which tests are run. A test may contain one or more assertions.

  Assertion: Actual verification step to confirm that the data returned by the code under test is what we expect.


  ## Minitest vs. RSpec

  Minitest allows us to write tests that look like Ruby code, while RSpec uses a domain-specific language (DSL) that is more verbose and less readable.

  Minitest is included in the Ruby standard library, while RSpec is a gem that must be installed.


  ## SEAT approach

  - Setup: Prepare the test environment by creating objects and setting up data.
  - Exercise: Execute the code under test.
  - Assert: Verify that the code under test behaves as expected.
  - Teardown: Clean up the test environment by removing objects and data.

  The SEAT approach is commonly used in testing, and is the basis for the Minitest framework.


  ## Assertions

  Assertions are the verification steps that confirm that the code under test behaves as expected. Minitest provides a number of assertions that we can use to test our code. 
  
  Common assertions include:
    - `assert_equal` - Asserts that the expected value is equal to the actual value.
    - `assert_nil` - Asserts that the value is `nil`.
    - `assert_includes` - Asserts that the collection includes the specified value.
    - `assert_raises` - Asserts that the specified error is raised.
    - `assert_instance_of` - Asserts that the object is an instance of the specified class.
    - `assert_same` - Asserts that the two objects are the same object.
    - `assert_output` - Asserts that the specified output is printed to `STDOUT` or `STDERR`.
    - `assert` - Asserts that the expression is truthy.
    - `refute` - Asserts that the expression is falsey.
    - `assert_match` - Asserts that the pattern matches the string. 


# Core Tools/Packaging Code
  Besides the `ruby` command, A Ruby installation contains: 
  - Core library 
  - Standard library (`require`)
  - `irb` REPL (Read Evaluate Print Loop)
  - `rake` utility
  - `gem` command 
  - Documentation tools (`rdoc` and `ri`)

  ## Purpose of core tools
  - Rubygems
    - Packages of code that can be downloaded and installed for use in Ruby programs or from command line.
    - `pry`, `rubocop`, `rails`, etc. 
  - Ruby Version Managers
    - Programs allowing for installation, management, and use of multiple Ruby versions. 
    - RVM, Rbenv
  - Bundler 
    - Dependency manager Gem 
    - Allows configuration of which Ruby and Gems project needs. 
    - To use Bundler, you provide a file named `Gemfile` that describes the Ruby and Gem versions you want for your app. 
    - Bundler uses the `Gemfile` to generate a `Gemfile.lock` file via the `bundle install` command.
    - The `bundle exec` command ensures that executable programs installed by Gems don't interfere with your app's requirements. For instance, if your app needs a specific version of rake but the default version of rake differs, bundle exec ensures that you can still run the specific rake version compatible with your app.
    - Assists in distributing project to run on other systems. 
  - Rake 
    - Used to automate anything you may want to do with your application during the development, testing, and release cycles.
    - Uses: 
      - Set up required environment
      - Set up and initialize databases
      - Run tests
      - Install the app.. etc
    - Uses a `Rakefile` in project directory. 

  
  ## Gemfiles
    - Bundler utilizes `Gemfiles` to keep track of dependencies required for project. 
    - When we run `bundle install` Bundler will scan, download, and install all dependencies listed in `Gemfile` create a `Gemfile.lock` which shows all dependencies for the program. 
      - Includes all gems listed in `Gemfile` as well as any Gems that they depend on. 



  ## Core Tools Relationships
  - Ruby version manager
    - Top level, controls multiple installations of Ruby and all other tools. 
  - Gems
    - Each installation of Ruby can have multiple Gems.
    - Each Gem install may have multiple versions. 
  - Ruby Projects
    - Programs/libraries that make use of Ruby as primary development language.
    - Each Ruby project typically designed to use specific Ruby versions/gems.
  - Bundler
    - A Gem used to manage the Gem dependencies in the project. 
    - Determines and controls the Ruby version and Gems that project uses, and attempts to ensure that proper items are installed and used when program is run. 
  - Rake 
    - Gem that is not tied to any one Ruby project.
    - Tool to automate repetitive development tasks such as running tests, building databases, packaging and releasing software, etc. 
    - Use `Rakefile` to control which tasks your project needs. 

- The `.gemspec` file provides information about a Gem. If you decide to release a program or library as a Gem, you must include a `.gemspec` file. 



# Regular Expressions
  




# The Coding Challenge 