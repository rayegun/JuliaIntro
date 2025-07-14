+++
title = "Fun Examples"
ignore_cache = true
+++

```julia
println.(1:10 .|>_->prod(j->rand(["╱╲"...]),1:10));
```
