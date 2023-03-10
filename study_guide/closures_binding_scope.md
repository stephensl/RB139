# Closures
---
---

## What are closures?

Closures refer to the general programming concept of creating "chunks" of code that may be passed around and executed at a later time. Closures maintain their 'binding' to program artifacts that were in-scope when the closure was created, and we are able to expose and manipulate data that is part of the closure's binding from areas of the program which would otherwise be out of scope. A closure "carries" its binding as it is passed around within the program, and may be invoked directly or passed into methods depending on its implementation and intended use case. 

## What is a closure's binding?

Binding refers to the surrounding artifacts (variables, methods, constants) that are in-scope when the closure is created and 'bound' to the closure. This allows the closure to maintain its connection to surrounding data that may be exposed or manipulated as the closure is passed around and executed within the program. A closure's binding offers increased flexibility to access particular functionality from areas within the program that would otherwise be limited by scoping rules. 

## How does binding affect scope?
When a closure is defined, the surrounding artifacts (variable names, method names, constants) become a part of the closure's binding. Consequently, the closure will carry this binding and maintain access to the artifacts that comprise it throughout the program. We are then able to access data that is part of the closure's binding from areas of the program that would otherwise be out of scope. A closure does not carry the actual values as as part of its binding, but references to them. Changes to variables after the closure is created will be reflected in the closure's binding.

Example: 
```ruby 
def call_proc(my_proc)
  count = 500
  my_proc.call 
end 

count = 1 
my_proc = Proc.new { puts count }

p call_proc(my_proc)

# 1
# => nil 
```

The example above will output `1` and return `nil`. The closure's binding includes local variable `count` as it is defined in the outer scope. Even though the method-local-variable `count` is initialized within the `call_proc` method, the closure maintains its connection to its binding. 

## How does Ruby implement closures?

Ruby implements closures through: 
  - Blocks
  - `Proc`s 
  - `lamdba`s