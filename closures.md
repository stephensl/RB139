# Study and Practice: Closures/Blocks

## Important Points 

- A closure is a chunk of code that may be passed around and executed later.
- Ruby implements closures through blocks, `Proc`s and lambdas.
- The code in the block is not the method implementation. 
- The block is passed in to the method like any other argument. 
- It is up to the method implementation to decide what to do with the block. 
- Every method in Ruby takes an optional block as an implicit argument.
- Use yield keyword to invoke the passed-in block argument from within the method.


# Blocks 
```ruby 
def echo_with_yield(str)
  yield 
  str 
end 

echo_with_yield { puts "world" } # => ArgumentError 
echo_with_yield("hello") { puts "world" } # outputs: "world" and returns "hello"
```
---

## Calling method that contains yield keyword without block:
```ruby 
echo_with_yield("hello")  # => LocalJumpError: no block given

# Method should be updated to include conditional evaluating presence of block.

def echo_with_yield(str)
  yield if block_given?
  str 
end 
```

---

## Passing execution to the block
- Method implementation: 

```ruby 
def say(words)
  yield if block_given?
  puts "> " + words 
end 
```

- Method invocation 

```ruby 
say("hi there") do 
  system 'clear'
end 

# Clears screen first, then outputs "> hi there" 
```

---

## Yielding with an argument 

```ruby 
def increment(number)
  if block_given?
    yield(number + 1)
  end 
  number + 1
end 

increment(5) do |num|
  puts num 
end 

# => Outputs: 6 and Returns 6.
```

### Giving wrong number of arguments to block
- Too many block arguments: 

```ruby 
def test 
  yield(1, 2) # passing in two block arguments at block invocation time
end 

test { |num| puts num } # expecting 1 parameter in block implementation 

# => Outputs: 1, Returns nil. Additional argument is ignored 
```

- Passing too few block arguments when block expecting more

```ruby 
def test 
  yield(1)   # passing 1 block argument at block invocation time 
end 

test do |num1, num2|       # expecting 2 parameters in block implementation
  puts "#{num1} #{num2}"     
end 

# => Outputs 1 and empty space, Returns nil. 

# num2 is never assigned and is nil, when nil is interpolated in the string, returns an empty space. 
```

---

## Arity 
The rule regarding the number of arguments you must pass to a block, `proc`, or `lambda` is called its ***arity***.
- Methods enforce the argument count, while blocks do not. 

- Blocks and `proc`s have a *lenient arity* 
  - Ruby does not complain when you pass in too many or too few arguments. 
- Methods and `lambda`s have a *strict arity* 
  - Must pass exact number of arguments that the method or `lambda` expects. 


