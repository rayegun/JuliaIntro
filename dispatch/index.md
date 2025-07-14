+++
title = "Multiple Dispatch"
ignore_cache = true
+++

<!-- Setup -->

\activate{notebooks/}

# The Promised Land: Multiple Dispatch

\toc

## Rock Paper Scissors
Let's play rock paper scissors:

```!
abstract type Shape end
struct Rock     <: Shape end
struct Paper    <: Shape end
struct Scissors <: Shape end

play(::Paper, ::Rock)     = "Paper wins"
play(::Paper, ::Scissors) = "Scissors wins"
play(::Rock,  ::Scissors) = "Rock wins"
play(::T,     ::T) where {T<: Shape} = "Tie, try again"
play(a::Shape, b::Shape) = play(b, a) # Commutativity
```
```>
play(Paper(), Scissors())
play(Rock(), Paper())
play(Scissors(), Scissors())
```

We've got a lot of new stuff going on here! First we have the `::Paper` statement. This syntax exists for when you don't care about the value of an argument, and only its type.

Second we have the syntax:
```julia
play(::T,     ::T) where {T<: Shape} = "Tie, try again"
```
Much like parametric structs this is a parametric method with a slot named `T` which must be a subtype of `Shape`. ***Notice that both arguments have the same type `T`***

Next we have our first real look at the difference between a `Function` and a `Method`, and how to perform specialization:

### Functions and Methods

```>
play
methods(play)
```
So what's going on here?

A function is really just a name for a table of 1 or more *methods*. When you call a function in Julia the arguments you provided have concrete types, for instance when I call:
```>
play(Paper(), Rock())
```
Julia will go searching for a function named `play` with ***most specific signature*** that matches my arguments. Instead of `(Paper(), Rock())` as the input to `methods` we pass the type of the argument tuple:
```>
dump(methods(play, Tuple{Paper, Rock}))
```
🤯
\important{Until you are spelunking through the Julia compiler you never need to look at this}{But it's still neat to peek behind the curtain}.

## The ***most specific signature***??

What does that even mean? We're going to borrow very liberally from the wonderful [Matthijs Cox](https://scientificcoder.com/the-art-of-multiple-dispatch) who also gave us our opening little comic.

Let's let's take a function `f` and a really restricted set of types: `Float64, Int, String` and visualize what dispatch really looks like

\image{The Cube}{/assets/images/dispatch1.png}{width:100%}

When `f` takes no arguments, the method we select is clear. But you'll notice that each argument we add squares the number of possible methods we could write.

\image{Signature Coverage}{/assets/images/dispatch2.png}{width:100%}

\important{Abstract types, Unions, and parametric methods}{ exist solely to help cover different parts of these spaces (which are often much much larger). Otherwise the parent type has nothing to do with the child type.}

```!
f(::Any, ::Any) = println("Any & Any")
f(::Int64, ::Int64) = println("Int & Int")
```
```>
f(:🐷, "Oink oink!")
f(1, 2)
```
\image{Signature Overlap}{/assets/images/dispatch5.png}{width:100%}

We have overlapping dispatches now, but the most specific one wins

## Ambiguity 😱
```!
f(::Any, ::String) = println("Any & String")
f(::String, ::Any) = println("String & Any")
```
```>
f("This is fine", 5)

f(5, "So is this!")

f("Now", "What?!")
```
\image{Ambiguity!}{/assets/images/dispatch6.png}{width:100%}

We have to fix our ambiguity with:
```!
f(::String, ::String) = println("Phew, crisis averted")
```

\image{Dispatches all put together}{/assets/images/dispatch7.png}{width:100%}
