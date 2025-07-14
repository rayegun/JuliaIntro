+++
title = "Home"
+++

# Julia Intro for QNumerics Summer School

\toc

## What is Julia?
Julia is a high-level, general-purpose programming language that is well suited for numerics, computational science, and scientific computing.

## Why Julia?

### 2-language Problem


\image{Who is Julia for?}{/assets/images/comic.png}{width:120%}

The scientific, artificial intelligence, and research computing world has a two language problem
1. Most scientists use "simpler" but ***slow*** languages like Python or Matlab
2. As problems get bigger, we must turn to systems languages like C, C++, or Rust

The end result?
- Researchers face a productivity cliff and must spend valuable time translating and performance engineering
- The average user can't meaningfully interact with their tools, adapt them to their needs:
  - Try changing Tensorflow or MATLAB internals!
- Lost performance at the interface of libraries like PyTorch and the C++ backends

### Expression Problem

> "To which degree can your application be structured in such a way that both:
> \\
> \\
> (1) &nbsp;&nbsp;&nbsp;&nbsp;the ***data model***  
> \\
> (2) &nbsp;&nbsp;&nbsp;&nbsp;and the set of ***virtual operations*** over it  
> \\
> \\
> can be extended without the need to modify existing code, without the need for code repetition and without runtime type errors." -- Mads Torgersen, "The Expression Problem Revisited"

The expression effectively states the difficulty of allowing:
1. New types to be added to existing operations
2. and new operations added to existing types

without changing code.

|                                                         |  Functional Languages (Ocaml, Haskell, F#)  | Class-based Object Oriented Languages (C++, Java) |
| ------------------------------------------------------- | :-----------------------------------------: | :-----------------------------------------------: |
| **New types** and *existing operations* |  ~~~<span style="color:red"><b>HARD</b></span>~~~  |    ~~~<span style="color:green"><b>EASY</b></span>~~~   |
| **New operations** to *existing types*           | ~~~<span style="color:green"><b>EASY</b></span>~~~ |     ~~~<span style="color:red"><b>HARD</b></span>~~~     |

#### Julia solves this problem with **multiple dispatch**

More on this later, but multiple dispatch allows anyone to add new functions to existing types and new types to existing functions *with no interaction*!

### Fast ***can*** be simple:

\image{Computer Language Benchmark Game}{/assets/images/clbg.png}{width:100%}


### Package Management

### Code rarely looks like the underlying math


## Julia vs. Other Languages

### Python

### C++

## Other Resources
