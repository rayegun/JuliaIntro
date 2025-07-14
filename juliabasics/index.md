+++
title = "First Steps"
ignore_cache = true
+++

<!-- Setup -->

\activate{notebooks/}

# Julia First Steps

\toc

## The REPL

## Package Management

# Basic Syntax
Julia has a fairly simple syntax which is:
1. "Close to the math" so that code resembles the equivalent algorithm in plain math or pseudocode. Unicode symbols can help get even closer to math notation.
2. Avoids too much unique syntax / keywords in favor of macros
3. Familiar (enough) to users of MATLAB or Python


\important{Everything in Julia is an _expression_:}{(Almost) every piece of syntax in Julia is an ***expression***. That means that is has an associated ***value***. For instance the expression `2 + 2` has the value `4`.\\
Keep this in mind as we go through the code.}

\literate{./_literate/basics.jl; project=./notebooks/}

That covers most of the basic syntax we will need to get started. 

## A note on scope
Variables or names are part of a scope:
```>
x = 5
foo(y, z) = x + y + z # x is available from global scope
foo(10, 20)
bar(x, y) = x - y # x is "shadowed" by the argument
bar(10, 3)
```

```>
module Mod
    x, y, z = (1, 2, 3)
    foo(z) = println(x, y, z)
end
import .Mod
x = 50
Mod.foo(10)
```

## Arrays!
Forgive the section title 😇

\literate{./_literate/arrays.jl; project=./notebooks/}

# A bit of fun

## Tips Tricks and Conventions

### Can't figure out how to type a Unicode character?
We will be using lots of Unicode characters throughout the week. If you can't figure out how to type a character, but you're able to copy and paste it into the REPL you can use the `help` REPL we discussed earlier:

```!
help?> 🤔 #mock
```

### 
