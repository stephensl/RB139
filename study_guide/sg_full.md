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
    - Offers increased utility through generic behavior that may be specialized at invocation time via the block. 

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

- We can think of & as doing 3 (or maybe 2-1/2) different, but related things. What it does depends on where it is and what comes after it.

  - Can be in method definition, prepended on a parameter name
    - Here, `&` will take a block, convert it into a `Proc` and assign it to the parameter name

  - Can be in method invocation, prepended on an argument
    - Here it takes a Proc and converts it to a block to be passed as an argument
    - When `&` is used with an object argument during method invocation, it converts the object into a Proc object if it is not already a Proc. The resulting Proc object can be used as a block argument in the method.
    - But, if what comes after is NOT a Proc it will call to_proc on that object and then proceed with converting it to a block to be passed
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
- Closures encapsulate the state and implementation details of a particular "chunk" of functionality
- Flexibility to pass closures around as objects and reuse them in different contexts.
- Ability to create generic methods that can be specialized at invocation time through the use of blocks.
- Ability to sandwich code before and after a block of code, which can be useful in timing, logging, notification systems, and resource management.
- Increased Code reusability and easier to maintain. 

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
  - Blocks can also be assigned to variables using the `Proc.new` method or the `&` operator, in which case they are converted to proc objects. 
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
  - A block can access local variables that were in scope when the block was defined, even if that variable is no longer in scope when the block is executed.
  - A block can modify the value of a local variable that was in scope when the block was defined (subject to variable shadowing rules). 
  - Local variables must be defined *before* the closure is created in order to be accessed by the closure, unless passed in explicitly when the closure is called.
  
  
  ## Write methods that use blocks and procs
  - Every method in Ruby takes an implicit block, which is utilized according to method implementation details.
  - Use `yield` keyword to yield control to the block. 
  - Blocks may be passed into methods implicitly or explicitly using explicit block parameter by prepending `&` to the final method parameter. 

  ## How does Kernel#block_given? work?

  - `Kernel#block_given?` will check to see if `yield` would execute in the current context without raising an error. If `yield` will execute then `Kernel#block_given?` will return true, if `yield` will raise an error then `Kernel#block_given?` will return false.
  
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

  - Test suite: A collection of tests that are grouped together and run together. Test suite includes all tests for a particular project. 

  - Test: A certain situation or context in which tests are run. A test may contain one or more assertions.

  - Assertion: Actual verification step to confirm that the data returned by the code under test is what we expect.

  - Testing frameworks: They provide:
    - a way to describe what kind of test you want
    - a way to execute those tests
    - a way to report the results of the tests




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





### Additional Questions 

 BLOCKS

1, What are closures?

Closures are a 'chunk of code' that can be passed around to be called upon later on. Within Ruby, Blocks, Proc objects and Lambda's are all closures.

2, What is binding?

Binding is the relationship that closures share with the surrounding artifacts (methods, variables, constants) of its scope upon being defined. Closures can access and/or update these artifacts regardless of when or where the closure is called upon later, we call this behavior and relationship, binding.

3, How does binding affect the scope of closures?

Binding allows closures to access variablse, methods, constants based on the scope of when the closure is defined and not when it is called upon. Therefore this allows closures and whatever is calling upon the closure to access or manipulate data that may be completely out of its normal scope, had there been no binding.

Example

```ruby
def some_method(pro)
  puts pro.call # the local variable `name` is out of scope for the method, but is accessible through binding
end
name = 'Joe'
some_proc = proc { name }

some_method(some_proc)
```

This example shows us that a closure (the proc) is bound to the local var `name` and is able access it even if it is called upon within a method, where local variable are normally not accessable unless explicitly passed in as an argument upon method invocation.

LS Example:

```ruby
def for_each_in(arr)
  arr.each { |element| yield element } # the `results` array is out of scope, but is accessible through binding
end

arr = [1, 2, 3, 4, 5]
results = [0]

for_each_in(arr) do |number|
  total = results[-1] + number
  results.push(total)
end

p results # => [0, 1, 3, 6, 10, 15]
```

4, How do blocks work?

Blocks are an unnamed chunk of code that are passed into methods. Blocks are defined by the `do..end` statements and `{}` curly brackets. The return value of blocks are determined by the last evaluated line on code within the block.

5, When do we use blocks? (List the two reasons)

- when we want to delegate the implementation of the method to the caller of the method.

- when we want to have a before and after (sandwich) code within our method.

6, Describe the two reasons we use blocks, use examples.

-We want to delegate the implementation of a method to the caller of the method when the implementor of the method does not know the desired outcome of the code. The method will accept a block that will define the desired outcome of the method.
Example:

```ruby
[1,2,3,4,5].map { |n| n.to_s }
```

In this example we can see that the `map` method will iterate through an array and return a new array but what goes into the new array is determined by the block passed in by the caller.

- We want to use a block when we have a method that requires a before and after implementation of something. The block will be implemented between the before and after and will return some desired value that is needed for the after.
  Example:

```ruby
def some_method(string)
puts string
new_string = yield(string)
puts "#{string} is now #{new_string}!"
end

```

7, When can you pass a block to a method? Why?

You can pass a block to a method upon invocation at any time. Methods have an implicit parameter that is not visible to us but will accept a block at any time. The method will need to be defined in a specific way to access that block, but even if a method is not defined to accept blocks, it will not raise an error when a block is passed in.

8, How do we make a block argument manditory?

We require a block in a method by using the `yield` keyword in the method definition or if expecting an explicit block then using the `#call` method to call the block (which is now actually a proc) that is assigned to the parameter variable.

Example:

```ruby
def some_method(&block)
  block.call
end

def some_method_2
  yield
end

```

9, How do methods access blocks passed in?
Methods use the keyword `yield` to invoke implicit blocks passed in and use the `Proc#call` method to invoke explicit blocks passed in.
Example:

```ruby
def some_method(&block)
block.call #explicit block invocation
yield # implicit block invocation
end
```

10, What is `yield` in Ruby?

`yield` in Ruby is a keyword used in a method definition that calls implicit and eplicit blocks passed into the method. `yield` can accept arguments and pass them into the block and assign them to the block local variable defined it its parameters.

11, How do we check if a block is passed into a method?

We can use the `Kernel#block_given?` method to see if an implicit block was passed into the method. `#block_given?` will return a boolean, true if `yield` would execute in the current context and fale if `yield` would not execute in the current context.

12, Why is it important to know that methods and blocks can return closures?

It is important to know that closures can be returned from and passed to other methods because this allows us to access data that would usually be out of scope and pass along functionality allowing for DRY and flexible code. It is also important to remember that closures returned from method and blocks that are defined withing those methods and/or blocks will have access to the artifacts within the scope of those methods and/or blocks, thus allowing the returned closure to reference and/or alter those artifacts at a later time.

Example:

```ruby
def retained_array
  arr = []
  Proc.new do |el|
    arr << el
    arr
  end
end

arr = retained_array
p arr.call('one') #=> ["one"]
p arr.call('two') #=> ["one", "two"]
p arr.call('three') #=> ["one", "two", "three"]
```

Example:

```ruby
def contained_data(password)
  Proc.new do |new_password|
    password = new_password unless new_password.nil?
    password
  end
end

joes_password = contained_data("joesmith2022")
p joes_password.call #=> "joesmith2022"
p joes_password.call("joeharvy2022") #=> "joeharvy2022"

```

Example from LS:

```ruby
def sequence
  counter = 0
  Proc.new { counter += 1 }
end

s1 = sequence # a unique memory is created and retained of the `counter` var in the `sequence` method
p s1.call           # => 1
p s1.call           # => 2
p s1.call           # => 3
puts

s2 = sequence #= a new unique memory is created and retained of the `counter` var of the `sequnece` method
p s2.call           # => 1
p s1.call           # => 4 (note: this is s1)
p s2.call           # => 2
```

13, What are the benifits of explicit block?

Explicit blocks allow us to reference the block (now a proc) within the method definition via a variable and allows to the pass the block to other methods or return the block. It also allows us to be able to return the explicit block from the method as a proc object.
Example:

```ruby
def some_method  #implicit block
  return yield
end

puts some_method {"Joe"} #=> "Joe"

def some_method2 (&bloc)
  return bloc
end

puts some_method2 {"Joe"} #=> proc object <Proc:0x000055b5376f6d68>
```

14, Describe the arity differences of blocks, procs, methods and lambdas.

Blocks and proc's both have lenient arity, meaning they accept less or more arguments than the defined parameters without raising an error. All unassigned parameter variables are set to nil. Methods and lambda's have a strict arity, meaning the number of arguments passed in must match the number of parameters defined otherwise an error is raised.

15, What are other differences are there between lambdas and procs? (might not be assessed on this, but good to know)

Proc is a class and procs are instantiations of that class. Lambda's are also an instance of Proc but cannot be instantiated via `Lambda.new`, because `lambda` is a `kernel#lambda` method that creates a proc object with a few changes compared to a normal proc object. Lambda has strict arity while proc's have lenient arity. When `return` is explicitly stated in a lambda the control is returned to the calling method, however when `return` is explicitly stated in a proc the control will not return to the calling method, but will simply end the calling method.

16, What does `&` do when in a the method parameter?

```ruby
def method(&var); end
```

It converts the passed in block into a simple proc object allowing it to be assigned to the parameter variable appending the unary ampersand symbol `&`.

17, What does `&` do when in a method invocation argument?

```ruby
method(&var)
```

It checks to see if the passed in argument is a proc obj and converts it into a block. If it isnt' a proc obj it will call `#to_proc` on it to convert it into aproc obj first then convert it into a block. If the passed in object is not a proc obj and does not have a `#to_proc` method an error will be raised.

Example:

```ruby
def some_method
  puts yield # => outputs "HI"
end
ppp = proc {'HI'}

some_method(&ppp) #converts the proc into a block
```

18, What is happening in the code below?

```ruby
arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`
```

The unary ampersand symbol `&` is going to call `#to_proc` on the symbol `:to_s` to change it into a block to then be passed into the `#map` method.

```ruby
# :to_s.to_proc -> block

p arr.map { |n| n.to_s } # code would look like this after conversion if executed
```

19, How do we get the desired output without altering the method or the method invocations?

```ruby
def call_this
  yield(2)
end

to_s = proc { |n| n.to_i }
to_i = proc { |n| n.to_s }

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

20, How do we invoke an explicit block passed into a method using `&`? Provide example.
Example:

```ruby
def method_a(&block)
  block.call
  yield
end

method_a { puts "HI!!"}
```

21, What concept does the following code demonstrate?

```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```

This is an example of sandwich code, one of the reasons we use blocks in ruby.

22, What will be outputted from the method invocation on line 84? Why does/doesn't it raise an error?

```ruby
def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

The output will be `"This is a turtle and a ."`. This will not raise an error because blocks have lenient arity, meaning they can accept more or less arguments than defined without raising an error. Any unassigned parameter variables will be assign to nil.

23, What will be outputted if we add the follow code to the code above? Why?

```ruby
block_method('turtle') { puts "This is a #{animal}."}
```

This will raise an error `NameError` because the block is looking for variable/method `animal` within the block and cannot find it. Block parameter variables must be defined to accept arguments passed into `yield`.

24, What will the method call `call_me` output? Why?

```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

The `call_me` method call will output `hi Griffin`. This is because the proc object `chunk_of_code` is bound to the local variable `name` and will see the changes made to it even after the proc object is defined.

25, What happens when we change the code as such:

```ruby
def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

This will raise an error because the proc object cannot find the local variable `name`. Variables referenced within block must be intialized before the block is defined.

26, What will the method call `call_me` output? Why?

```ruby
def call_me(some_code)
  some_code.call
end

def name
  "Joe"
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)
```

This will output `hi robert` because even though we have both a local variable and method with the same name `name`, local variables have precidence when variables and methods have the same name. Hence, the proc `chunk_of_code` will reference the local variable `name` and not the method `name`.

27, Why does the following raise an error?

```ruby
def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)
```

The `&` is trying to call the `to_proc` method on the string object `a` but the string class does not have a `to_proc` method and hence an error is raised.

28, Why does the following code raise an error?

```ruby
def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)
```

The above code will raise an error because we are trying to assign a block to a local variable, which cannot happen because blocks are not objects.

29, Why does the following code output `false`?

```ruby
def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)
```

The above code will output false because we are not passing in a block, but a proc object. If we prepent a unary ampersand symbol `&` before the passed in argument on `line 393` and before the parameter variable `block` on `line 387` of `some_method` then the output will be `true`.

30, How do we fix the following code so the output is `true`? Explain

```ruby
def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc)
```

Answer ==>

```ruby
def some_method(&block) # or simply remove the explicit block parameter
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(&bloc)
```

By prepending the unary ampersand symbol `&` on both locations allow us to remove the positional arguments of the method invocation and method definition and pass in a block in their stead. The unary ampersand symbol `&` in the method invocation converts the proc obj into a block and the unary ampersand symbol `&` in the method definition makes the block an explicit block parameter. Therefore because a block is being passed into the method `#block_given?` will return `true`, even though the explicit block parameter will convert the block into a proc obj. We could simply remove the explicit block parameter as well and we would get the same return value.

31, How does `Kernel#block_given?` work?

`Kernel#block_given?` will check to see if `yield` would execute in the current context without raising an error. If `yield` will execute then `Kernel#block_given?` will return `true`, if `yield` will raise an error then `Kernel#block_given?` will return `false`.

32, Why do we get a `LocalJumpError` when executing the below code? &
How do we fix it so the output is `hi`? (2 possible ways)

```ruby
def some(block)
  yield
end

bloc = proc { p "hi" } # do not alter

some(bloc)
```

We get a `LocalJumpError` because the `yield` keyword is searching for a block passed into the method, but no implicit or explicit block has been passed in. To remedy this we can use the unary ampersand symbol `&` in the following locations.

Possible answer 1 ==>

```ruby
def some(&block)
  yield
end

bloc = proc { p "hi" } # do not alter

some(&bloc)
```

Possible answer 2 ==>

```ruby
def some
  yield
end

bloc = proc { p "hi" } # do not alter

some(&bloc)
```

33, What does the following code tell us about lambda's? (probably not assessed on this but good to know)

```ruby
bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

(Try to figure this one out yourself ;)

34, What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assessed on this, but good to know ;)

```ruby
def lambda_return
  puts "Before lambda call."
  lambda {return}.call
  puts "After lambda call."
end

def proc_return
  puts "Before proc call."
  proc {return}.call
  puts "After proc call."
end

lambda_return #=> "Before lambda call."
              #=> "After lambda call."

proc_return #=> "Before proc call."

```

(try to figure this one out yourslef ;)

35, What will `#p` output below? Why is this the case and what is this code demonstrating?

```ruby
def retained_array
  arr = []
  Proc.new do |el|
    arr << el
  end
end

arr = retained_array
arr.call('one')
arr.call('two')
arr.call('three') << 4
p arr.call("five")
```

The output will be `["one", "two", "three", 4, "five"]`. The code demonstrates the binding rules of closures defined within a method and returned from that method. We can see though this example that closures defined within a method will be bound to the artifacts found within the scope of that method. In this case the proc obj is bound to the local variable `arr` within the method definition. Hence when we call the returned proc object the proc object will push the passed in argument into the array assigned to the local var `arr` even though the variable `arr` is out of scope and normally not accessible outside the method definition.

# TESTING WITH MINITEST

28, What is a test suite?

A collection of tests.

29, What is a test?

The environment in which an assertion is executed. A test can have multiple assertions.

30, What is an assertion?

An assertion is the actual process we use to confirm if a certain code performs an expected way.

31, What do testing frameworks provide?

They provide a way to describe the type of tests desired, a way to execute those tests and a way to report/display the results.

32, What are the differences of Minitest vs RSpec

Minitest is written in Ruby and RSpec uses a DSL and reads like English. Minitest used to be included in Ruby and so many developers are familiar with Minitest.

33, What is Domain Specific Language (DSL)?

A Domain Specific Language is a computer programming language unique to a certain environment (its domain). Ruby is a general programming language.

34, What is the difference of assertion vs refutation methods?

assertion methods test to see if things are the same or truthy, refutations test to if things are not the same or falsy.

35, How does assert_equal compare its arguments?

It uses the `==` method to compare its arguments.

36, What is the SEAT approach and what are its benefits?

Set up objects to test, execute code on those objects, assert the results of the execution, tear down objects.

37, When does setup and tear down happen when testing?

Before each and every test.

38, What is code coverage?

The percentage of a program that is tested.

39, What is regression testing?

Testing for bugs after updates or changes to a program that was previously working correctly to ensure that the whole program continues work properly.

# CORE TOOLS

40, What are the purpose of core tools?

Ruby core tools help developers develop, maintain, launch, streamline and automate code.

41, What are RubyGems and why are they useful?

Gems are a package of code to be used in a program or in the command line and provide functionality originally not found in Ruby.

42, What is Version Control and why are they useful?

Version managers allow one to control which versions of Ruby we have and determine which version our program will run on. This allows us to work on multple projects using different versions of ruby without conflict.

43, What is Bundler and why are they useful?

Bundler is a Gem that uses a Gemfile to consolidate and determine the needed dependencies and their versions for your program. Bundler uses the Gemfile to download and install the needed dependencies for your program. Bundler further prevents your program from running gems from your library and only from those dependencies that you downloaded through the Gemfile. By creating a `Gemfile` and `Gemfile.lock` Bundler prevents your program from running the wrong ruby version, gem versions, rake version, etc and only run the versions that you determined in the `Gemfile`. Bundler must be installed on each version of ruby if using a version manager.

44, What is Rake and why is it useful?

Rake is a Gem that helps streamline project managament and developement by automating tasks when building, maintaining, testing, packaging and installing. Rake is included in modern ruby installation.

45, What constitues a Ruby project?

A project is considered a Ruby project if the programming language primarily used within the project is Ruby.
