# Julia has a fantastic built-in standard library for linear algebra.
using LinearAlgebra

# ### What is an "Array" in Julia?
# Many languages have different concepts of arrays.
# In a language like C you might use raw pointers 😱.\\
# In a language like Python you might use NumPy arrays or PyTorch tensors

#md # !!! warning "Types"
#md #     This section will start talking a bit about types.
#md #     If it's a bit confusing don't worry, the next section will clear up any confusion!

# In Julia the array types stick pretty close to the mathematical sense of the word.
# The most common three array types in Julia are:
Vector{T} where T
#-
Matrix{T} where T
#-
Array{T, N} where {T, N};

# If this syntax is confusing to you don't worry! We'll talk more about this later but the expressions above are ***types***. Specifically they are ***parametric types*** with a placeholder `T` for the element type. The `N` parameter for array is the dimension, which is an integer!

# We can substitute different things such as types for the placeholder `T`, for instance:
Vector{Int64}
# is a `Vector` with 64-bit integer elements.

# If we go a bit further we can create high dimensional array types:
Array{Bool, 6}

# Notice that `Vector` and `Matrix` are simply aliases for the a 1 dimensional and 2 dimensional `Array` respectively

# ### Constructing arrays
# We've already seen literals several times!
[1,2,3]
# Here's some new literals!
["🐞" "🐕"
 "🐻" "🧚"]
#-
A = [1 2; 3 4]

# There are *lots* of ways to write array literals in Julia. Check out your cheatsheet for more.

# #### Comprehensions
# We have a funky syntax for constructing called *comprehensions*:
[x for x in 1:10 if x % 3 == 1]
#-
[i + j for i in 1:4, j in 1:3]

# #### Constructors
# Every type in Julia has constructors, which are functions that return a specific type
# We have constructors for basic numeric types and strings:
Float64(10)
String("asdf")

# The most basic array constructors:
Vector{Int64}(undef, 5) # 5 element Vector
#-
Matrix{Float32}(undef, 2, 3)

# Notice that the values are random. The `undef` constructors, which use the special `undef` global constant contain uninitialized memory whose values haven't been set to zero.

# There is also special juxtaposition syntax for empty arrays:
Float32[]

# #### Functions that generate arrays:
zeros(Bool, 3)
#-
zeros(5, 5)
#-
fill(1 + 10im, 2, 2)
#-
rand(Int8)
#-
rand(5)
#-
rand([:🐱, 🐶, 🐦, 🐴])

# You can see above how we have used the `rand` function for 3 completely different tasks above. We will talk more about this with `methods` later.

# ### Indexing
v = collect(1:2:9)
#-
v[4] # 1-based indexing!
#-
M = [1 2 3
     4 5 6
     7 8 9]

# We can still index `M` with a single integer:
M[5]
# Can you guess what is happening above? This is called *linear indexing*

M[2, 3] # "cartesian" indexing

# ### Slicing
M[:, 1]
#-
M[2, :]
# The `:` is a placeholder for the entire range of the specified dimension

# ### Fancy indexing
M[[1, 3, 6]]

#-
bools = rand(Bool, length(v))
#-
v[bools]

# We can use the boolean version of indexing and the broadcasting we discussed earlier to filter!
v = rand(1:10, 8)
#-
v[v .> 5]

# ### Setting values
# Getting values from an array is very similar to setting them:
M[2, 2] = 10
# But wait!!! Why is the value of the expression the RHS?
# We can see that `M` has been modified:
M

# We can use all the same fancy indexing with a catch, if we refer to multiple indices on the left hand side we must use broadcasting!
M[:, 1] .= 2M[:, begin]
#-
M
# We can use the `begin` and `end` keywords instead of the 1st index (which might *not* be 1 😈) and the last index in a dimension.

# We get off easy with the broadcasting above since the shapes of the left hand side and right hand side obviously matched. What if they didn't?

M[1, 1:2] .= [1,2,3]

# 💥💥💥💥!

# ### A few important functions that on Arrays
#-
size(M)
#-
@show length(M) == size(M, 1) * size(M, 2)

# Reshape a 6 element range into a matrix, then flatten it into a vector
vec(reshape(collect(1:6), 2, 3))
# What happens if we take away the collect?
vec(reshape(1:6, 2, 3)) # we'll talk about this kind of trick later

# Concatenating arrays is an important but tricky operation
vcat([1, 2, 3], [4, 5, 6])
#-
hcat([1,2,3], [4,5,6])

# We can do more than just set specific indices of arrays (well, at least Vectors).
# Julia's `Vector` type can grow and shrink:

v = [] # Notice the type of `v`
#-
push!(v, :🧡)
push!(v, :🚙)
pushfirst!(v, :💙)
# We've got a new convention to examine! In the Julia universe by convention (but not enforced by the compiler), functions which mutate one or more argument have `!` as a suffix.
v
#-
pop!(v)
#-
v
