+++
title = "First Steps"
ignore_cache = true
+++

<!-- Setup -->

\activate{./}

# Julia First Steps

\toc

## The REPL

\tldr{The Julia REPL has 4 modes: Julia, package (`]`), help (`?`) and shell (`;`).}

The Read-Eval-Print Loop (or REPL) is the most basic way to interact with Julia, check out its [documentation](https://docs.julialang.org/en/v1/stdlib/REPL/) for details.
You can start a REPL by typing `julia` into a terminal, or by clicking on the Julia application in your computer.
It will allow you to play around with arbitrary Julia code:

```>repl-example
a, b = 1, 2;
a + b
```

This is the standard (Julia) mode of the REPL, but there are three other modes you need to know.
Each mode is entered by typing a specific character after the `julia>` prompt.
Once you're in a non-Julia mode, you stay there for every command you run.
To exit it, hit backspace after the prompt and you'll get the `julia>` prompt back.

### Help mode (`?`)

By pressing `?` you can obtain information and metadata about Julia objects (functions, types, etc.) or unicode symbols.
The query fetches the docstring of the object, which explains how to use it.

```?help-example
println
```

If you don't know the exact name you are looking for, type a word surrounded by quotes to see in which docstrings it pops up.

### Package mode (`]`)

By pressing `]` you access [Pkg.jl](https://github.com/JuliaLang/Pkg.jl), Julia's integrated package manager, whose [documentation](https://pkgdocs.julialang.org/v1/getting-started/) is an absolute must-read.
Pkg.jl allows you to:

* `]activate` different local, shared or temporary environments;
* `]instantiate` them by downloading the necessary packages;
* `]add`, `]update` (or `]up`) and `]remove` (or `]rm`) packages;
* get the `]status` (or `]st`) of your current environment.

As an illustration, we download the package Example.jl inside our current environment:

```]pkg-example
add Example
```

```]pkg-example
status
```

Note that the same keywords are also available in Julia mode:

```>pkg-example-2
using Pkg
Pkg.rm("Example")
```

The package mode itself also has a help mode, accessed with `?`, in case you're lost among all these new keywords.

### Shell mode (`;`)

By pressing `;` you enter a terminal, where you can execute any command you want.
Here's an example for Unix systems:

## Environments

\tldr{Activate a local environment for each project with `]activate path`. Its details are stored in `Project.toml` and `Manifest.toml`.}

As we have seen, Pkg.jl is the Julia equivalent of `pip` or `conda` for Python.
It lets you [install packages](https://pkgdocs.julialang.org/v1/managing-packages/) and [manage environments](https://pkgdocs.julialang.org/v1/environments/) (collections of packages with specific versions).

You can activate an environment from the Pkg REPL by specifying its path `]activate somepath`.
Typically, you would do `]activate .` to activate the environment in the current directory.
Another option is to directly start Julia inside an environment, with the command line option `julia --project=somepath`.

Once in an environment, the packages you `]add` will be listed in two files `somepath/Project.toml` and `somepath/Manifest.toml`:

* `Project.toml` contains general project information (name of the package, unique id, authors) and direct dependencies with version bounds.
* `Manifest.toml` contains the exact versions of all direct and indirect dependencies

If you haven't entered any local project, packages will be installed in the default environment, called `@v1.X` after the active version of Julia (note the `@` before the name).
Packages installed that way are available no matter which local environment is active, because of "environment [stacking](https://docs.julialang.org/en/v1/manual/code-loading/#Environment-stacks)".
It is recommended to keep the default environment very light to avoid dependencies conflicts. It should contain only essential development tools.

\vscode{

You can configure the [environment](https://www.julia-vscode.org/docs/stable/userguide/env/) in which a VSCode Julia REPL opens.
Just click the `Julia env: ...` button at the bottom.
Note however that the Julia version itself will always be the default one from `juliaup`.

}

\advanced{

You can visualize the dependency graph of an environment with [PkgDependency.jl](https://github.com/peng1999/PkgDependency.jl).

}

## Package Management
We're going to explore how package management and code structure typically works using [this repository](https://github.com/giordano/StarWarsArrays.jl)

# Basic Syntax
Julia has a fairly simple syntax which is:
1. "Close to the math" so that code resembles the equivalent algorithm in plain math or pseudocode. Unicode symbols can help get even closer to math notation.
2. Avoids too much unique syntax / keywords in favor of macros
3. Familiar (enough) to users of MATLAB or Python


\important{Everything in Julia is an _expression_:}{(Almost) every piece of syntax in Julia is an ***expression***. That means that is has an associated ***value***. For instance the expression `2 + 2` has the value `4`.\\
Keep this in mind as we go through the code.}

\literate{./_literate/basics.jl; project=./}

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

\literate{./_literate/arrays.jl; project=./}

# A bit of fun

## Tips Tricks and Conventions

### Can't figure out how to type a Unicode character?
We will be using lots of Unicode characters throughout the week. If you can't figure out how to type a character, but you're able to copy and paste it into the REPL you can use the `help` REPL we discussed earlier:

```!
help?> 🤔 #mock
```

### 
