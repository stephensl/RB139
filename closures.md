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

---

## Return value of yielding to block
```ruby 
def compare(str)
  puts "Before: #{str}"
  after = yield(str)  # after assigned return value from block 
  puts "After: #{after}"
end 

compare('hi') { |word| word.upcase }

# Before: hello
# After: HELLO
# => nil
```

Blocks can, like normal methods, mutate the argument with a destructive method call or the block can return a value. 

```ruby 
compare('hello') { |word| puts "hi" }

# Before: hello
# hi
# After:          # nil in string interpolation is empty string 
# => nil
```

---

## When to use blocks in own methods
- Two main use cases: 
  - Defer some implementation code to method invocation decision.
    - Write more generic version that can be adapted to particular use case by method user at invocation time. 
    ```ruby 
    [1, 2, 3].select { |num| num.odd? } # block at invocation time
    ```
  - Sandwich code
    - Methods that need to perform some before and after actions. 
    ```ruby 
    def time_it 
      time_before = Time.now 
      yield 
      time_after = Time.now 

      puts "It took #{time_after - time_before} seconds."
    end 

    time_it { sleep(3) } 
    # => It took 3.003767 seconds
    ```
  
  ---

## Methods with explicit block parameter
An explicit block is a block that gets treated as a named object. 
  - It gets assigned to a method parameter so that it can be managed like any other object 
    - Can be reassigned, passed to other methods, and invoked many times. 
  - To define explicit block, add a parameter to method definition where the name begins with `&` character. 

```ruby 
def test(&block)
  puts "What's the &block? #{block}"
end 

test { sleep(2) }

# Outputs: What's the &block? #<Proc:0x000001ad11df6460 sandbox.rb:5>
# => nil 
```
In the code above, the `block` local variable is now a `Proc` object. 

### An explicit block provides additional flexibility as we can now do more than simply yield to the block. Now that we have a variable that represents the block we can pass the block to another method: 

```ruby 
def test2(block)
  puts "hello"
  block.call 
  puts "good-bye"
end 

def test(&block)
  puts "1"
  test2(block)   # block is already a Proc object when passed to test2
  puts "2"
end 

test { |prefix| puts "xyz" }

# 1 
# hello 
# xyz 
# good-bye 
# 2 
# => nil 
```

## Arguments and explicit blocks 
You can pass arguments to the explicit block by using them as arguments to `call`. 
```ruby 
def display(block)
  block.call(">>>")
end 

def test(&block)
  puts "1"
  display(block)
  puts "2"
end 

test { |prefix| puts prefix + "xyz" }

# 1
# >>>xyz
# 2 

# => nil 
```

### Ruby converts blocks passed in as explicit blocks to a simple Proc object (this is why we need to use #call to invoke the Proc object).

---

## Using closures 
Closures retain memory of their surrounding scope and can use and update variables in that scope when they are executed, even if the block, `Proc` or `lambda` is called from somewhere else.
```ruby 
1:  def for_each_in(arr)
2:    arr.each { |element| yield element }
3:  end 
4:  
5:  arr = [1, 2, 3, 4, 5]
6:  results = [0]
7:  
8:  for_each_in(arr) do |number|
9:    total = results[-1] + number 
10:    results.push(total)
11:  end 
12:  
13:  p results # => [0, 1, 3, 6, 10, 15]
```
### Though the block passed to `for_each_in` is invoked from inside the `for_each_in` method, the block still has access to the `results` array through closure. 

Walking through this code line by line: 
- Line 8: invoke `for_each_in` method, and pass in `arr` and a block as arguments
- Line 1: Array object `arr` assigned to method parameter `arr`. 
- Line 2: invoke `each` method on `arr` with a block. 
  - block defines one parameter `element`
  - each element is yielded to the block via iteration
- Line 8: block parameter `number` assigned to `element`. 
- Line 9: block local variable `total` assigned to return value of `results[-1] + number` 
- Line 10: block local variable `total` pushed to `results` array
- Line 11: block ends
- Line 2: next element passed in to block passed to `each` and yielded to block beginning on Line 8. 
- Repeat for each element in `arr` 
- Line 13: Invoke `p` method and pass in `results` as argument. 
  - Outputs array. 


---

## When a method or a block returns a closure
- Methods and blocks can return Procs and lambdas that can subsequently be called.
```ruby 
def sequence
  counter = 0 
  Proc.new { counter += 1 }
end 

s1 = sequence 
p s1.call     # 1
p s1.call     # 2
p s1.call     # 3

s2 = sequence 
p s2.call     # 1
p s2.call     # 2
p s1.call     # 4 
```
In this code the `sequence` method returns a `Proc` object that forms a closure with local variable `counter`. 
- We can call the returned `Proc` repeatedly.
- Each time we call it, it increments its own private copy of `counter`. 

### We can create multiple `Proc`s from `sequence` and each will have its own independent copy of `counter`. 

---