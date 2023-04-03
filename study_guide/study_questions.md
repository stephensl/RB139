# BLOCKS

1, What are closures?

Closures are a general programming concept describing the practice of saving "chunks" of code that can be passed around and executed at a later time. Closures allow increased flexibility to reuse functionality, and maintain access to key artifacts within the program from areas of the codebase which would otherwise render them out of scope. Closures are implemented in Ruby through blocks, `Proc` objects, and `lambda`s. 

2, What is binding?

Binding refers to a closures "memory" of the code artifacts that were in scope at the time the closure was created. These artifacts may include names of variables and methods, and allow the closure to access and update values that are part of the closure's binding. A closure "drags" its binding, which is memory of its surrounding context, as it is passed around within the program. 

3, How does binding affect the scope of closures?

Binding creates a greater level of flexibility as closures maintain their connection to the context in which they were created by maintaining access to artifacts like variables and method names that in scope when the closure was created. When the closure is executed elsewhere in the program, we are able to access, reassign, and update variables that are part of the closure's binding, even when, without the use of closures, they would not be in scope. Thus, we have greater agency in accessing components of the program that are part of the closure's binding. 

4, How do blocks work?

Blocks are one way that Ruby implements closures. Blocks are ubiquitous in Ruby, and they are identified by either curly braces {} or a do..end statement. Blocks are "chunks" of code that are useful especially in working with collections, as we are able to pass each element of the collection to some mechanism within the block. Blocks provide a modularized piece of functionality that can be powerful in directing refined behavior of methods. Any Ruby method can take an implicit block, and the way in which the block is utilized is dependent upon the implementation details of the method- whether the block is ignored or invoked, and how the return value of the block is used. 

5, When do we use blocks? (List the two reasons)

Two major use cases for blocks include: 
  - Deferring some implementation details to method invocation time. This allows the programmer to define methods in a generic manner, and allow for method users to elicit more specialized behavior by passing in a block at invocation time. This allows for greater flexibility and more diverse use case for methods. A method implementor does not need to know all the ways in which the method will be used, but can instead provide a structure for a the method to be adapted for a particular use case but taking a block as an argument. 

  - Sandwich code: blocks are useful in sandwiching code to provide some kind of before and after behavior. The method implementor does not need to be concerned with what kind of behavior will be defined in the block provided by the method user, only that the method will be defined to perform a "before" behavior, yield to the block, then perform the "after" behavior. This again adds to flexibility and utility of methods, and allows greater personalization for method users. Examples of use cases for sandwiching code include timing certain functions, providing resource management (opening files, yielding to block, closing file), notifications, logging behavior. 

6, Describe the two reasons we use blocks, use examples.

Example of deferring implementation detail to invocation time. 

### Deferring to Implementation time 
```ruby 
class Score 
  attr_accessor :score 

  def initialize
    @score = 0 
  end 

  def add_to_score
    puts "Previous Score: #{score}"
    self.score = yield(score)
    puts "New Score: #{score}"
  end 
end 

mine = Score.new 

mine.add_to_score { |pts| pts += 5}

p mine.score # => 5
```

### Sandwiching code
```ruby 
def time_function
  before = Time.now 
  yield if block_given?
  after = Time.now 

  puts "Time taken: #{after - before} seconds"
end 

time_function { (1..100).each { |num| puts num } }

# => Time taken: 0.000401 seconds
```

7, When can you pass a block to a method? Why?

Any Ruby method can accept an implicit block argument. Whether or not, and the manner in which the block is utilized is dependent on the method implementation details. The method may be defined to invoke the block, ignore it, utilize the return value of the block, or a variety of other functions. 

When the method explicitly defines a parameter that starts with &, such as &block or &callback. This signals to Ruby that the method should accept a block argument.

When calling a method, a block can be passed as an argument after the parentheses. For example:

8, How do we make a block argument mandatory?

In order to make a block argument mandatory, we should define the method in a way that indicates an explicit block parameter. This is achieved by prepending a `&` to the final parameter in the method definition. Prepending an `&` provides indication that the method is expecting a block argument, and automatically converts the passed in block to a 'simple proc' object that may be passed around and invoked inside the method, or passed to other methods. 

9, How do methods access both implicit and explicit blocks passed in?

Methods access both implicit and explicit blocks passed in by either yielding to the block, or explicitly invoking the block from within the method body.

Implicit blocks can only be yielded to, as they do not have an explicit "handle" which would allow the block to be treated as a named object. 

```ruby 
arr = [1, 2, 3]

arr.select { |num| num. odd? }
```
In this case, we simply iterate through the array, and yield each element to the block. 

```ruby 
arr = [1, 2, 3]

def increment_element(arr, &block)
  counter = 0 
  results = []

  while counter < arr.size 
    results << block.call(arr[counter] + 1) if block_given?
    counter += 1
  end

  p results 
end

increment_element(arr) do |elem|
  puts "incremented to #{elem}"
end 
```



10, What is `yield` in Ruby and how does it work?

The `yield` keyword in Ruby is how we 

11, How do we check if a block is passed into a method?

12, Why is it important to know that methods and blocks can return closures?

13, What are the benefits of explicit blocks?

14, Describe the arity differences of blocks, procs, methods and lambdas.

15, What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)

16, What does `&` do when in a the method parameter?

```ruby
def method(&var); end
```
17, What does `&` do when in a method invocation argument?
```ruby
method(&var)
```

18, What is happening in the code below?

```ruby
arr = [1, 2, 3, 4, 5]
p arr.map(&:to_s) # specifically `&:to_s`
```

19, How do we get the desired output without altering the method or the method invocations?

```ruby
def call_this
  yield(2)
end
# your code here
p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

20, How do we invoke an explicit block passed into a method using `&`? Provide example.

21, What concept does the following code demonstrate?

```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```

22, What will be outputted from the method invocation `block_method('turtle')` below? Why does/doesn't it raise an error?

```ruby
def block_method(animal)
  yield(animal)
end
block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

23, What will be outputted if we add the follow code to the code above? Why?

```ruby
block_method('turtle') { puts "This is a #{animal}."}
```

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

25, What happens when we change the code as such:

```ruby
def call_me(some_code)
  some_code.call
end
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"
call_me(chunk_of_code)
```

26, What will the method call `call_me` output? Why?

```ruby
def call_me(some_code)
  some_code.call
end
name = "Robert"
def name
  "Joe"
end
chunk_of_code = Proc.new {puts "hi #{name}"}
call_me(chunk_of_code)
```

27, Why does the following raise an error?

```ruby
def a_method(pro)
  pro.call
end
a = 'friend'
a_method(&a)
```

28, Why does the following code raise an error?

```ruby
def some_method(block)
  block_given?
end
bl = { puts "hi" }
p some_method(bl)
```

29, Why does the following code output `false`?

```ruby
def some_method(block)
  block_given?
end
bloc = proc { puts "hi" }
p some_method(bloc)
```

30, How do we fix the following code so the output is `true`? Explain

```ruby
def some_method(block)
  block_given? # we want this to return `true`
end
bloc = proc { puts "hi" } # do not alter this code
p some_method(bloc)
```

31, How does `Kernel#block_given?` work?

32, Why do we get a `LocalJumpError` when executing the below code? &
How do we fix it so the output is `hi`? (2 possible ways)

```ruby
def some(block)
  yield
end
bloc = proc { p "hi" } # do not alter
some(bloc)
```

33, What does the following code tell us about lambda's? (probably not assessed on this but good to know)

```ruby
bloc = lambda { p "hi" }
bloc.class # => Proc
bloc.lambda? # => true
new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

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