# Symbol to `proc` 

## Transforming items from collection

We can use shorthand:

`(&:odd?)` is converted to `{ |n| n.odd? }`

```ruby 
[1, 2, 3, 4, 5].select(&:odd?)
```
 

### What's happening

  - Applying the `&` operator to an object (possibly referenced by variable)
    - Ruby tries to convert object to a block.
      - If object is a `proc` conversion to block happens easily
      - If not a `proc`, must convert to `proc` first calling `to_proc`. 
        - Ruby can then convert the `proc` to a block.


## Example:

```ruby 
array = [1, 2, 3, 4, 5]

array.map(&:to_s)

# => ['1', '2', '3', '4', '5']
```

  - `&:to_s` tells Ruby to convert the Symbol `:to_s` to a block.
  - Since `:to_s` is not a `Proc`, Ruby first calls `Symbol#to_proc` to convert the symbol to a `Proc`. 
  - Ruby converts the `Proc` to a block. 


Breaking down the steps: 

```ruby 
def my_method
  yield(2)
end 

a_proc = :to_s.to_proc
my_method(&a_proc) 