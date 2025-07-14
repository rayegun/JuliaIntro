# ## Loading packages
# Before we get into basic syntax we will need a few packages for this tutorial.
# While you can load packages at any top-level scope, it's best practice to do so at the beginning of your file, package, or notebook.
using LinearAlgebra, Random, CairoMakie # for plotting

# ## Literals and Variables
# A literal is a representation of some data directly in code. For instance:
4
# is the literal for the 64-bit Integer number $4$.\\
# **Note:** Since this is an expression is has a value of 4.
# Notebooks and the REPL will automatically print out the value of an expression (or the last expression in a code block), *unless* the value of an expression is the special constant:
nothing

# The other way to suppress the output of an expression is to use `;` character which can also be used to delimit multiple statements on a single line.
5; 6; 7;

# Other literals include:

"Howdy folks!"; # string
3.14159265     # floating point (Float64)
true           # Boolean
[1, 2, 3, 4]   # Vector of Int64
#-
(1, 3.14159, "Quantum? Never met 'em!") # A Tuple (an immutable fixed length collection)
# Now that we have literals we might like to give them a name.
# We can assign literals (and any other data) to a variable, which is simply a named value:
a = [1,2,3,4]
w = 10
y = true
# We can interpolate into strings by either `$y` or `$(w + 2)` for more complex expressions
x = "Are are at UMass Amherst? $y"
# Assignments are an expression whose value is the right-hand-side.
# This lets us, among other things, chain assignments:
i = j = 5; # both i and j are equal to 5
@show i j

# Variables are not constrained to a particular type.
x = 13.5 # reassign x to a different type.

# Julia has support for Unicode variable names.
# In VSCode and the REPL we can use autocompletion such as `\Sigma`-TAB-`\hat`-TAB-`\^2`-TAB
Σ̂² = 1.0;

# There is complete support for all of Unicode, so that means we have emoji as well!
😳 = 5 # `\:flushed`-TAB
⚛️ = "Quantum Numerics!" # I don't think this has an autocomplete yet 🤔

# Julia allows for *numeric* literals to be **immediately** followed by a variable, which results in multiplication:
3x
# This helps us write long equations very nicely:
4(x + 3)^2 - 10

# This functionality is also used for complex number literals, with the global constant `im`:
10 + 3im

# ## Operators and Functions
# Like most languages Julia has two syntaxes for operating on values: operators and function calls.
#
# ### Operators
w + x + Σ̂²
#-
2 ^ 5 # exponentiation
# There are also Unicode operators, for instance this is integer division:
5 ÷ 2 # (`5 \div`-TAB-`2`)
#-
∛8 # `\cbrt`-TAB-`8`

# The boolean operators are:
!y # negation
false && y # short circuiting and
y || true # short circuiting or

# The `<op>=` operators update a variable, such as:
w += 3

# ### Functions
# Functions are called much as they are in other languages like Python:
sin(2x)
#-
length(a)
#-
complex(1.0, 10)

# There are three syntaxes for defining functions. The first two produce named functions, and we'll get to the third in a moment.
# The general form is:
function foo(x, y)
    ## we don't actually need the `return` here
    ## the last expression is returned by default
    return x + y
end
# and the terse form which is typically used if your function is a single expression:
bar(x, y) = x + y

# We can call this function as above:
@show foo(w, x) == bar(w, x)

# #### Keyword and optional arguments
# We can add "keyword" arguments to a function by placing them after a semicolon in the arguments:
function mykwargs(a; b)
    a ^ b
end;

# Both positional arguments and keyword arguments can be made optional by providing a default value.
# Ignore the `@show` for now we'll get to that later, it prints out the expression and its result.
function myoptionalfunc(a = 2; b = 3)
    a ^ b
end
@show myoptionalfunc()
@show myoptionalfunc(b = 3)
@show myoptionalfunc(5)
@show myoptionalfunc(5, b = 2)

# Operators are "just" functions with support for infix notation (except `&&` and `||` which uniquely short circuit)
+(1, 2, 3, 4)
#-
f = *
f(1, 2, 3)

# #### Functions are data
# Just like strings or vectors and can be assigned to variables:
baz = foo
baz(w, x)

# They can also be passed to other functions:
map(sin, [1.0, 2.0, π])

# #### Anonymous functions
# The third syntax for defining a function is for so-called anonymous functions (functions without a name)
x -> 5x + (x - 1)^2
# Of course we didn't give it a name, so now we have no way to reference it!
# These are most often used to pass to "higher-order" functions (functions that accept other functions as arguments):
map(x -> 5x + (x - 1)^2, a)

# For anonymous functions with multiple arguments the syntax looks like this:
(x, y, z) -> x/3 + y^3 + z^2

# or with zero arguments like this:
() -> 2 + 2

# ### Broadcasting
# We often encounter situations where we want to call a function such as `sin`
# over all elements of a collection like a `Vector`.
# In order to make this ergonomic Julia supports a generalized "broadcasting" syntax:
sin.([1, 2, 3])
# Any function can be suffixed with a `.` in order to broadcast it elementwise over each value in a collection.
# This also works elementwise, for instance:
complex.([1, 2, 3], [10, 20, 30])
# or with operators in infix form:
[1, 2, 3] .+ [4, 5, 6]

# ## Control Flow
# We now know how to define variables, call functions and operators, and define basic functions.
# For a bit of a break let's look at the following function which computes a single point in the mandelbrot set to get a sense for control flow:
function mandel(z)
	c = z
	maxiter = 80
	for n in 1:maxiter
	  if abs(z) > 2
		  return n-1
	  end
	  z = z^2 + c
	end
	return maxiter
end;

# We need a complex plane to compute the set on:
resolution = 0.02
reals = -2:resolution:1 # range from -2 to 1 with step size of 0.02
imgs = -1:resolution:1
plane = [complex(re, img) for (re, img) in Iterators.product(reals, imgs)];
results = mandel.(plane);

# We're going to use a package called CairoMakie to plot the result:
CairoMakie.heatmap(results)

# Let's break down some of the expressions we saw above:
# ### Conditionals
# We have a conditional block above which tests whether `abs(z) > 2`.
# A general control flow block looks something like:
x = 5; y = 10; z = true
if x < y
    println("Small x!")
elseif x == y
    println("x and y are equal!")
else
    println("Big x!")
end

# Many languages have a ternary expression, for a short way to evaluate a two way conditional:
println(x < y ? "x is less than y!" : "x is greater than or equal to y!")

# Julia users really like to keep code compact, so there is one additional conditional expression you might see:
x < y && println("x was less than y!")

x < y || println("I don't get here if x < y!")

# It's important to note that conditional expressions (like `if-elseif-else`) are *short-circuiting*.
# This means that in the expression:
# ```julia
# a && b
# ```
# `b` is only evaluated if `a` is `true`!
# Similarly in
# ```julia
# a || b
# ```
# `b` will only be evaluated if `a = false`

# ### Loops
# Our `mandelbrot` function also has a `for` loop iterating over the range `1:maxiter`.
#
# There are two loop constructs in Julia. `while` loops:
i = 1;
while i <= 5
    println("i = $i")
    i += 1
end

# and `for` loops (note that `i` is local to the `for` loop block, unlike with the `while` above):
for i in 1:2:9
    println("i = $i")
end

# `for` loops can iterate over many different containers, including the `Vector`s, `Tuple`s,
# `StepRange`s like `1:2:9`, `UnitRange`s like `1:10` and more.

# Instead of the `in` keyword we can also use `=` and `∈` (`\in`-TAB).

# When we are looping over containers like `Vector`s it's important to be sure we know what we are looping over!
# We will get to indexing when we talk about arrays in the next section, but for now we can index a `Vector` as follows:
emojis = ["🤔", "⚛️", "💻"];
@show emojis[1]
@show emojis[3]
# Notice that Julia is (**generally**) 1-based, **not** 0 based!
println("Iterating over each value:")
for i ∈ emojis
    println(i)
end

println("Iterating over the indices:")
for i ∈ 1:length(emojis)
    println(i)
end

println("Iterating over the indices but printing value:")
for i ∈ eachindex(emojis)
    println(emojis[i])
end

# Notice that we switched to using `eachindex` instead of `length`. Can you guess why?


# #### `break` and `continue`
# If you need to stop a loop early the `break` keyword will immediately terminate a loop.
# If you need to skip an iteration the `continue` keyword will immediately start the next iteration of the loop.

for i ∈ emojis
    i == "⚛️" && continue
    println(i)
end
