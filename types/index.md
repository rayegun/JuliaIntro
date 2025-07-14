+++
title = "Types, What Are They Good For?"
ignore_cache = true
+++
# Types, What Are They Good For?
\activate{notebooks/}
```julia
using AbstractTrees
```

## Every value has a type:
```>
typeof(3.14159265)

typeof(π)

typeof(rand(3))

typeof([1, 1.5, true]) # What happened here?

typeof(1.5 + 1//3 .- [1, 2, 3])
```
### What about functions?
```>
typeof(sin)
typeof((x, y) -> x + y^2) # Why does this look so weird?
```

## Type assertions
The most common place you will see types is constructors:
```>
Int128(3)
Vector{Float64}(undef, 2)
Complex{Float64}(1.0, 3.0)
```

and in ***type assertions***:

```>
3.0::Float64

3.5::Int64

(1.5 + 10)::Float64
```

You can read `::Float64` as "is an instance of `Float64`". A type assertion ensures or states that the left hand side is a ***subtype*** of the right hand side. What does that mean?

You may know of inheritance from a language like Java or C++, or even Python. In those languages you can create a type (classes in some languages), and then create a second type that inherits the fields and behavior of the parent.

On the other hand Julia has a tree of abstract types, with what we call ***concrete*** types on the leaves:

```julia
AbstractTrees.children(x::Type) = subtypes(x)

print_tree(Number)
```
