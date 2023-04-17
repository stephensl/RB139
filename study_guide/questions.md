1. Use of `&` operator in defining vs calling methods. 

```ruby 
def a_method(&block)
  block.call 
end 

my_proc = Proc.new { puts "Hello from proc" }

a_method(&my_proc) 
# Hello from proc 
# => nil 
```



