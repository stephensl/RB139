# BLOCKS

1, What are closures?

Closures are 

2, What is binding?

3, How does binding affect the scope of closures?

4, How do blocks work?

5, When do we use blocks? (List the two reasons)

6, Describe the two reasons we use blocks, use examples.

7, When can you pass a block to a method? Why?

8, How do we make a block argument mandatory?

9, How do methods access both implicit and explicit blocks passed in?

10, What is `yield` in Ruby and how does it work?

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