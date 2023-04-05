=begin 

- Line 17: we invoke outer_method and pass in the argument 10.

- Line 3: execution begins in outer_method as method argument (10) is assigned to method parameter x.

- Line 4: invoke the puts method and pass in the string "Before inner method: x = #{x}" with the interpolated value of x (10).
  
  - String printed to the screen "Before inner method: x = 10", and nil returned to the outer_method method. 

- Line 6: we invoke the inner_method method and pass in the argument x (10) and a block. 

- Line 13: execution begins in inner_method as method argument (10) is assigned to method parameter z. We include an explicit block argument in method parameters.

- Line 14: we invoke the block.call method and pass in the argument z (10).

- Line 6: block is executed and block parameter y is assigned to z (10).

- Line 7: we increment y by 5 and reassign the value of y to 15. The block returns the value of y (15) to the inner_method method.






