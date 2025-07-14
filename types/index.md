+++
title = "Types, What Are They Good For?"
ignore_cache = true
+++
# Types, What Are They Good For?

\activate{notebooks/}
```!
using InteractiveUtils # hide
```
```!
using AbstractTrees
```

### All values have a single concrete concrete type which is a leaf of a single global type tree. All types are "first-class"

```>
typeof(3.14159265)

typeof(π)

typeof(rand(3))

typeof([1, 1.5, true]) # What happened here?

typeof(1.5 + 1//3 .- [1, 2, 3])
```

Some languages such as Java have a distinction between certain primitive types like `Int64` and classes. While Julia does have primitive and non-primitive types:
```>
isprimitivetype(Int64)
isprimitivetype(Vector{String})
```
The user experiences no difference, the distinction is purely for bootstrapping.

### Variables are just names, and are untyped

```>
x = 1.0
typeof(x)
x = [1,2,3]
typeof(x)
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

\important{This syntax is central to Julia programming}{The type assertion syntax `::T` is used everywhere from struct definitions to Julia's all-important multiple-dispatch system which we will cover shortly. It is important to get comfortable with the meaning of this syntax}

You can read `::Float64` as "is an instance of `Float64`". A type assertion ensures or states that the left hand side is a ***subtype*** of the right hand side. What does that mean?

## The type tree
You may know about type inheritance from a language like Java or C++, or even Python. In those languages you can create a type (classes in some languages), and then create a second type that inherits the fields and behavior of the parent.

Julia on the other has a tree of abstract types (which contain no structure), and what we call ***concrete*** types on the leaves:

```!
AbstractTrees.children(x::Type) = subtypes(x)

# All of the subtypes of the abstract type Number in a tree
print_tree(Number)
```

Let's explore this type tree a little bit. At the top we have:
```?
Number
```

Since `Number` is not a leaf on our tree it is an ***abstract type***. A fragment of this type tree would be defined as follows:
```julia
abstract type Number end
abstract type Real          <: Number end
abstract type AbstractFloat <: Real end
abstract type Integer       <: Real end
abstract type Signed        <: Integer end
abstract type Unsigned      <: Integer end
```

`abstract type` should be fairly self explanatory, but we have a new operator! The `<:` subtype operator. `Number` has an implicit supertype here:
```!
supertype(Number)
```
```?
Any
```

We have already seen `Any` many times without realizing it:
```julia
foo(a, b) = 2a + 3b
```
is equivalent to:
```julia
foo(a::Any, b::Any) = 2a + 3b
```

Immediately you should notice that we might specialize `foo` on some subtypes of `Any`. 

## Structs

We've made do thus far with types defined by Julia, it's time we give it a shot!

One of the simplest types we might create is a `Point` consisting of two values `x` and `y`:
```!
struct Point1
    x
    y
end
```
```>
p = Point1(19, 97) # construct a Point1
p.x # access a field of p

p2 = Point1("North", [1, 2, 3, 4])
p.y
```

### Some features of a `struct`
- Types declared as `struct` are *immutable*:
  ```>
  p.x = 2
  p.y[1] = 10 # but not necessarily their fields
  p
  ```
- Immutable structs are *identical* or *indistinguishable if their fields are indistinguishable:
  ```>
  Point1(1, 2) === Point1(1, 2)
  ```
  ```?
  ===
  ```
- Because a copy is indistinguishable for an immutable struct, the compiler may optimize immutable values aggressively

### Why might `Point1` be bad?
Implicitly the fields `x` and `y` are of type `Any`:
```julia
struct Point1
    x::Any
    y::Any
end
```

We can instead restrict the types of each field by either concrete or abstract types:
```!
struct Point2
    x::Float64
    y::Number
end
```
```>
Point2(1.5, 3)
Point2([1,2,3], 4)
```

## Mutable structs
Mutable types are created in a similar manner:
```!
mutable sturct Point3
    x::Float64
    y::ComplexF64
end
```
But they differ in two ways:
1. We can mutate their fields:
   ```>
   p = Point3(1.0, 10 + 1im)
   p.x = 10
   p
   p2 = copy(p)
   p == p2
   p === p2
   ```
2. Since the value named `p` can change over time it can only be identified by it's address in memory. Hence types declared as `mutable struct` are typically stored with a stable address in memory.

