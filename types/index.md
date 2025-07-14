+++
title = "Types, What Are They Good For?"
ignore_cache = true
+++
# Types, What Are They Good For?
\toc

\activate{./}
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

## The Type Tree
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
\important{`p.x` and `p.y` retained their type}{despite the fact that the fields of `Point1` are `Any`. This is a fundamental feature of the language, that values never change type. *However* we will see that since the compiler will have trouble *predicting* the value of those fields ahead of time it must be pessimistic}

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
mutable struct Point3 <: Any
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
   p2 = Point3(10, 10 + 1im)
   p == p2 # we can write a new method for == to make this true
   p === p2 # we cannot make this true
   ```
2. Since the value named `p` can change over time it can only be identified by it's address in memory. Hence types declared as `mutable struct` are typically stored with a stable address in memory.

## When should you use a `struct` or a `mutable struct`?

- You might pick a `struct` if:
  - The data in your struct will never change
  - A copy of your struct is identifiable solely by its contents:
    - A number, or a point in space, is solely identified by its contents
    - Two cars fresh off the lot may appear exactly identical, but are not indistinguishable
  - You have thousands or millions of these structs stored in collections like `Vector`s
- You might pick a `mutable struct` if:
  - The contents are constantly changing
  - The value is large
  - The struct has identity unrelated to its contents

## Parametric Types
Our first `Point` struct had fields which could contain any value. That freedom is great, and Julia happily accepts this level of dynamism. But we have another often better solution with ***parametrization***.

We have already seen parametric types before:
```julia
mutable struct Vector{T} <: DenseVector{T}
    ref::MemoryRef{T}
    size::Tuple{Int64}
end
mutable struct Matrix{T} <: DenseMatrix{T}
    ref::MemoryRef{T}
    size::Tuple{Int64, Int64}
end
mutable struct Array{T, N} <: DenseArray{T, N}
    ref::MemoryRef{T}
    size::NTuple{N, Int64}
end
```

Let's take a look at the type tree they are part of:
```!
print_tree(AbstractArray)
```
The type tree for `AbstractArray` is massive, and that's with very few additional packages loaded which may add new subtypes. But it's deceptively small. We know that at least three of the types in this tree are parametric, and each one of those contains a potentially infinite subtree of subtypes.

So let's make our own infinite tree of subtypes:
```!
struct Point{T}
    x::T
    y::T
end
```

Play around with substituting various types, and let's examine the subtyping relationships which are a little bit subtle!
```>
Point{Complex{Float64}}

Point{AbstractArray}

Point{Complex{Float64}} <: Point

Point{AbstractArray} <: Point

typeof(rand(10, 10)) <: Point
# is equivalent to:
rand(10, 10) isa Point

isconcretetype(Point)

isconcretetype(Point{AbstractArray})
```

What will happen when I run this code?

```julia
Point{Float16} <: Point{BigInt}

Float64 <: Real

Point{Float16} <: Point{Real}
```

\important{Type parameters are *_invariant_*}{A `Point{Float16}` has a different representation from a `Point{Real}` in memory which at a low level must contain two pointers to arbitrary subtypes of `Real` while `Point{Float16}` is just `4`-bytes}

We can overcome this limitation if needed using the subtype operator `<:` again:

```>
Point{Float16} <: Point{<:Real}
```

### Abstract types can be parametric as well, with similar rules:
```?
AbstractArray
```

## What's the type of a type?
```>
typeof(Int64)

typeof(Vector) # 🤔

typeof(Vector{Float64})
```

The first and last examples right above were concrete types. But the middle one is a parametric type with no parameter! 

## Tuples
When you think of a `Tuple` type you should think of it as analogous to the arguments of a function:
```!
function foo(a, b, c)
    [a, b, c]' .^ 2 * [a, b, c]
end
```


# Advanced Topics 
## Unions
## UnionAlls
