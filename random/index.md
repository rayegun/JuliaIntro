+++
title = "Well I'm out of content so..."
ignore_cache = true
+++

<!-- Setup -->

\activate{./}


# Well I'm out of content so...

## A few random notes:
Miscellaneous things I didn't mention
### The compiler and the user can both generate methods
\important{You *and* the compiler generate specializations}{
    ```julia
    foo(a, b) = a * b + 2
    ```
    Will be fully specialized on input arguments when called.
    It won't appear in `methods` though.
}

### Avoiding ambiguities:
```julia
-(A::AbstractArray{T}, b::Date) where {T<:Date}
```
will cause ambiguities with:
```julia
-(A::MyArrayType{T}, b::T) where {T}
```

### High crimes and misdemeanors:
***Type piracy shall not be abided*** (well maybe a little sometimes)

```julia
module A
import Base.*
*(x::Symbol, y::Symbol) = Symbol(x,y)
end
```

### Type assertions 

Hopefully you've got some high level semantics of the language down.

I want to emphasize something I sort of alluded to, but maybe didn't say super explicitly:

\important{Separating Functions and Data ***implies*** multiple dispatch}{}

## Some notebooks we'll peruse together:

[Performant Serial Code](https://mitmath.github.io/Parallel-Computing-Spoke/notebooks/PerformantSerialJulia.html)

[Going Fast Nowhere](https://vchuravy.dev/talks/Going_fast_nowhere/)

[Gotta Dispatch em all](https://mit-c25-fall23.netlify.app/homeworks/hw1-2024)
