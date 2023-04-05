Lines 1-7    

Method definition for `#outer_method`, which is defined with one parameter, `x`. 

Line 9-11: 

Method definition for `#inner_method`, which is defined with one parameter, `y` and an explicit block parameter, `&block`.

Line 13: 

Invoke `#outer_method` and pass in the integer `10` as an argument. 

Line 1: 

Method parameter `x` is assigned to reference the integer `10`, which is passed in as an argument to `#outer_method`.

Line 2:  

Invoke `puts` and pass in the string `"Before inner method: x = #{x}"`.

Output:

`Before inner method: x = 10`

Line 3:  

Invoke the `#inner_method` from within `#outer_method` and pass in `x`, which references the integer `10`, and a block as an argument. 

Line 9:  

`inner_method` method parameter `y` is assigned to reference the value of `x` which was passed in as an argument. `y` now references the integer `10`.

`inner_method` method parameter `&block` is assigned to reference the block that was passed in as an argument to `#inner_method` when invoked inside of `#outer_method`.

The `&` in the method definition parameter `&block` is used to explicitly define a block parameter, and converts the passed in block to a `Proc` object. The `Proc` object is then referenced within the `inner#method` as method local variable `block`. 

Line 10: 

Invoke the `#call` method on the `Proc` object referenced by `block` and pass in `y` as an argument. 

At this point, `y` references the integer `10`. 

Line 3:  

Block is executed and `y` is assigned to block parameter `x`. 

Line 4: 

`x` is reassigned to the return value of `x + 5`, which is `15`.

The integer `15` is returned from the block. 

Line 11:  

Inner method returns the last expression evaluated, which is the return value of the block, and returns `15`. 

Line 6:  

Invoke `puts` and pass in the string `"After inner method: x = #{x}"`.

Output: `After inner method: x = 10` 

`outer_method` returns the last expression evaluated, which is the call to `puts` and returns `nil`. 

The reason that `x` is still `10` after the block is executed is because the block is executed in the context of the `inner_method` method, and the `inner_method` method does not have access to the local variables defined in the `outer_method` method.