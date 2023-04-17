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



Note that &, when applied to an argument object is not the same as an & applied to a method parameter, as in this code:
```ruby 
def foo(&block)
  block.call
end
```
While & applied to an argument object causes the object to be converted to a block, & applied to a method parameter causes the associated block to be converted to a proc. In essence, the two uses of & are opposites.

