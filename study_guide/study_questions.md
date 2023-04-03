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

The `yield` keyword in Ruby is how we invoke an implicit block from within a method. The `yield` keyword, "yields" control to the block, and executed according to the block's implementation details. Arguments can be passed into the block via arguments passed to `yield`. The method can check whether a block has been given via the `Kernel#block_given?` method. 

11, How do we check if a block is passed into a method?

The `Kernel#block_given?` method provides this functionality. Will return a boolean based on whether or not a block has been passed to the method. 

12, Why is it important to know that methods and blocks can return closures?

It is important to know that methods and blocks can return closures, because the closures returned can be utilized further or passed into other methods. When a closure is created, it retains its binding to the artifacts (variable/method names, etc.) that are in-scope when it is created. A closure returned from a method has a binding that allows for accessing and updating variables from different places in the program. Each closure maintains its own private copy of these variables. However, it is important to know that destructive method calls will mutate objects in place, and changes will be reflected throughout. 

13, What are the benefits of explicit blocks?

Explicit blocks communicate to the method user that the method expects a block. Explicit blocks also provide greater flexibility as we can refer to a "chunk" of code with a name, rather than simply yielding to it. We can then treat the closure as a named object which can be passed around the program, reassigned, invoked, or updated as needed. This contributes to DRY code, as the "chunk" of code may be reused throughout the program and invoked many times. We are also separating the block behavior from the method implementation, which makes the code more readable and adds to its generic utility based on use case. 

14, Describe the arity differences of blocks, procs, methods and lambdas.

Arity is concerned with the way in which blocks, procs, methods, and lambdas deal with arguments. Blocks and Procs both have lenient arity, which means that passing too many or too few arguments will not result in an exception, but any extra or ommitted arguments will be ignored. Methods and lambdas, by contrast have strict arity, and you must provide the precise number of arguments in order to avoid raising an exception for ArgumentError. 

15, What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)

Return behavior: Lambdas and procs handle returns differently. When a return statement is executed inside a lambda, it only returns from the lambda itself. However, when a return statement is executed inside a proc, it will return from the calling method.

Parameter handling: Lambdas handle parameters differently from procs. When a lambda is defined with a parameter that is never supplied with an argument, a LocalJumpError is raised. In contrast, when a proc is defined with an argument that is never supplied, the proc will simply return nil for that argument.

Object creation: Lambdas and procs are created differently. A lambda is created using the lambda keyword or the -> syntax, while a proc is created using the Proc.new method or the proc keyword.

Object class: Lambdas and procs are instances of different classes. A lambda is an instance of the Proc class, but with a special flag that indicates it is a lambda. A proc is simply an instance of the Proc class.

16, What does `&` do when in the method parameter?

```ruby
def method(&var); end
```
In this case, we define a method called "method" that takes an explicit block parameter `&var`. The & prepended to the parameter name indicates that the method takes a block, and shows that the passed in block will be converted to a simple proc object with the local variable name `var` when passed into the method. The `&` in the method parameter indicates that it accepts an explicit block and converts the block to a proc object in the method body. If the method receives a Proc argument, it must be invoked with & to convert it to a block before being passed to the method, where it will be transformed back into a proc. 


17, What does `&` do when in a method invocation argument?
```ruby
method(&var)
```

In a method invocation argument the `&` operator signifies that the argument being passed in should be converted to a block. In the code example, `&var` is expressing that the local variable `var` should be passed in as a block to the method. If `var` is already a Proc, this happens naturally as Ruby can easily convert Proc objects to blocks. If it is not a Proc, ruby will call `to_proc` in order to transform the object to a `Proc` then to a block that can be passed into the method. The block will be assigned an explicit name `var` within the method body. 

18, What is happening in the code below?

```ruby
arr = [1, 2, 3, 4, 5]
p arr.map(&:to_s) # specifically `&:to_s`
```

In this code, we have an `Array` object assigned to local variable `arr`. We then invoke the `Array#map` method on `arr` and pass in `&:to_s` as an argument. The `&` operator prepending the symbol in the argument to `map` first checks whether `:to_s` is a block, it is not, so Ruby calls `Symbol#to_proc` which converts the symbol to a `Proc`. Subsequently, the `Proc` is converted to a block `{ |i| i.to_s }`. 
The block is passed to `map` and executed. 


19, How do we get the desired output without altering the method or the method invocations?

```ruby
def call_this
  yield(2)
end

to_s = Proc.new { |num| num.to_i }
to_i = Proc.new { |num| num.to_s }

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

20, How do we invoke an explicit block passed into a method using `&`? 

We invoke an explicit block passed into a method using the `&` operator by invoking the `call` method on the `Proc` object. When a method is defined to accept an explicit block, the method defines an explicit block parameter by prepending the final parameter with `&`. This signifies that the method is expecting an explicit block. The block passed in, is transformed to a `Proc` object and assigned to the block parameter name. In the body of the method, we can invoke the `Proc` using `call` method or pass the `Proc` to other methods. 

21, What concept does the following code demonstrate?

```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```
This demonstrates "sandwich code" which is a major use case for blocks. Sandwich code allows the method to perform some before and after functionality that wraps the method user defined behavior in the block. The code above demonstrates the concept of defining generic methods that yield to a block in order to achieve a specialized behavior. As the method implementer, we are not concerned with the block behavior, only that we perform a 'before' action, yield to the block, then perform the 'after' action. This allows for more flexible utility of the method to meet a variety of use cases. 

22, What will be outputted from the method invocation `block_method('turtle')` below? Why does/doesn't it raise an error?

```ruby
def block_method(animal)
  yield(animal)
end
block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

This code will output: 

`"This is a turtle and a  ."`

This is the output as the method is defined to take a single argument, then yield that argument to the block. `block_method` is invoked and the string `"turtle"` is passed in as an argument along with a block. The block is defined with two block parameters, `turtle` and `seal`. Within the block, we invoke the `puts` method and pass in a string interpolated with the two block parameters. This will output `"This is a turtle and a  ."` as we supply only one of the two defined block arguments, while the other is ignored and set to `nil`. Thus when the values are interpolated in the string output by the block, it will include the first argument passed in `turtle` but `seal` when interpolated will evaluate to an empty space due to its `nil` value. This code does not raise an error because blocks have lenient arity and we are able to pass too many, too few, or the right amount of arguments to a block without raising an error. 

23, What will be output if we add the follow code to the code above? Why?

```ruby
block_method('turtle') { puts "This is a #{animal}."}
```
This would raise a NameError because `animal` is not defined in the block. In order for this to work, we'd have to add the block parameter. 

```ruby
block_method("turtle") { |animal| puts "This is a #{animal}."}`
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

On the final line, we invoke `call_me` method and pass in a `Proc` object referenced by local variable `chunk_of_code` as an argument. Within the `call_me` method, `chunk_of_code` is assigned to method parameter `some_code`, and is invoked in the body of the method using `some_code.call`. The output of this method will be `"hi Griffin"`. This is due to the binding of the closure assigned to `chunk_of_code`. When the `Proc` object assigned to `chunk_of_code` is created, local variable `name` had already been initialized to reference the string `"Robert"`. Since this was in the scope of the closure, it becomes part of its binding. After the closure is created, local variable `name` is reassigned to `"Griffin"` in the outer scope. Since the closure is bound to local variable `name`, its updated value is reflected. This is possible because `name` was already initialized at the time of closure creation.



25, What happens when we change the code as such:

```ruby
def call_me(some_code)
  some_code.call
end
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"
call_me(chunk_of_code)
```

This would generate an error as local variable `name` is not initialized at the time of creating the closure `chunk_of_code`, so is not part of its binding. As a result, we cannot access the local variable `name` from within the closure as it was initialized after the closure was created. As a result, when we invoke call_me(chunk_of_code), an error would be raised indicating that name is an undefined local variable or method.

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

This code will output "hi Robert" because closures in Ruby bind to local variables first before methods. If a local variable is in-scope and has the same name as a method, the closure will bind to the local variable due to precedence. 

27, Why does the following raise an error?

```ruby
def a_method(pro)
  pro.call
end
a = 'friend'
a_method(&a)
```

def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)

This example will raise a `wrong argument type String (expected Proc) (TypeError)`. The `&` prepended to the local variable `a` and passed as an argument to `a_method` will attempt to transform the value stored by `a` into a block. Since the `String` class does not define a `to_proc` method, we raise a TypeError. 

28, Why does the following code raise an error?

```ruby
def some_method(block)
  block_given?
end
bl = { puts "hi" }
p some_method(bl)
```

This code will raise an error as we are not able to define a block in this way. We are attempting to assign a block to a local variable, which is not possible, because blocks are not objects. We can invoke the method using the same syntax by assigning a `Proc` object to local variable `bl`. bl = Proc.new { puts "hi" }

29, Why does the following code output `false`?

```ruby
def some_method(block)
  block_given?
end
bloc = proc { puts "hi" }
p some_method(bloc)
```
This method will output `false` because the method is invoked with a `Proc` argument. The `Proc` object assigned to local variable `bloc` is passed into the `some_method` method and assigned to method parameter `block`. In the body of the method, `Kernel#block_given?` evaluates to false, as we have not provided a block to the method, but a `Proc` object. 

We could alter the code slightly by invoking the method with `some_method(&bloc)` and altering the method parameter to `&block` to signify an explicit block parameter. We could also remove the method parameter all together and pass in `&bloc` to the method, which would return `true` as the `&` converts the `Proc` object to a block. 


30, How do we fix the following code so the output is `true`? Explain

```ruby
def some_method(block)
  block_given? # we want this to return `true`
end
bloc = proc { puts "hi" } # do not alter this code
p some_method(bloc)
```

By prepending the unary ampersand symbol & on both locations allow us to remove the positional arguments of the method invocation and method definition and pass in a block in their stead. The unary ampersand symbol & in the method invocation converts the proc obj into a block and the unary ampersand symbol & in the method definition makes the block an explicit block parameter. Therefore because a block is being passed into the method #block_given? will return true, even though the explicit block parameter will convert the block into a proc obj. We could simply remove the explicit block parameter as well and we would get the same return value.

31, How does `Kernel#block_given?` work?

Kernel#block_given? will check to see if yield would execute in the current context without raising an error. If yield will execute then Kernel#block_given? will return true, if yield will raise an error then Kernel#block_given? will return false.

32, Why do we get a `LocalJumpError` when executing the below code? &
How do we fix it so the output is `hi`? (2 possible ways)

```ruby
def some(block)
  yield
end
bloc = proc { p "hi" } # do not alter
some(bloc)
```
This code raises an error because a block is not provided, thus when keyword `yield` is utilized, there is no block to yield to. 

Two possible ways to fix code: 

```ruby 
def some(&block)
  yield
end

bloc = proc { p "hi" } # do not alter
some(&bloc)
```
or
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

It shows us that lambda's are members of the `Proc` class and are not created using the `Lambda.new` syntax. A lambda appears to be a special kind of `Proc`. 

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

Procs return from the method within which the `Proc` is invoked. Lambda's simply return from the lambda and continue in the method scope. 

35, What will #p output below? Why is this the case and what is this code demonstrating?

```ruby 
def retained_array
  arr = []
  
  Proc.new do |el|
    arr << el
    arr
  end

end

arr = retained_array
arr.call('one')
arr.call('two')
p arr.call('three')
```

starting on line 418, local var `arr` is assigned to reference to return value of `retained_array()` which is a `Proc` object. 

line 419 we execute the `Proc` by invoking the `call` method on `arr` and passing in the string `"one"`. 
The argument `"one"` is passed into the block and assigned to block parameter `el`. `el` is then added to `arr` which is the method local variable inside the `retained_array` method. the final call to `p` method on the last line will output 
`["one", "two", "three"]`

The output will be ["one", "two", "three", 4, "five"]. The code demonstrates the binding rules of closures defined within a method and returned from that method. We can see though this example that closures defined within a method will be bound to the artifacts found within the scope of that method. In this case the proc obj is bound to the local variable arr within the method definition. Hence when we call the returned proc object the proc object will push the passed in argument into the array assigned to the local var arr even though the variable arr is out of scope and normally not accessible outside the method definition.