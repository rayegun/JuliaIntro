+++
title = "Types, What Are They Good For?"
ignore_cache = true
+++
# Types, What Are They Good For?

There are a few important features of Julia's type system we'll mention here up-front as they do in the [Manual](https://docs.julialang.org/en/v1/manual/types/)

### All values have a single concrete concrete type which is a leaf of a single global type tree. All types are "first-class"

Some languages such as Java have a distinction between certain primitive types like `Int64` and classes. While Julia does have primitive and non-primitive types:
```>
isprimitivetype(Int64)
isprimitivetype(Vector{String})
```
The user experiences no difference, the distinction is purely for bootstrapping.

### Julia has no distinction between a "compile-time type" and a "run-time type". A value has a single concrete type, and it never loses this type ***ever***

We'll explain this more in a bit, but in short 

- Variables are just names, and are untyped
- 
\activate{notebooks/}
```!
using InteractiveUtils # hide
```
```!
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

```!
AbstractTrees.children(x::Type) = subtypes(x)

# All of the subtypes of the abstract type Number in a tree
print_tree(Number)
```

Let's explore this type tree a little bit. At the top we have:
```?
Number
```

Since `Number` is not a leaf on our tree it is an ***abstract type*** 
