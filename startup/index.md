+++
title = "Setting Up Your Environment"
ignore_cache = true
+++

<!-- Setup -->

\activate{./}


# Setting Up Your Environment

\toc

## Git
\tldr{Visit [education.github.com](https://education.github.com/git-cheat-sheet-education.pdf) for a nice cheatsheet}
## VSCode
\tldr{Install `VSCode` from [code.visualstudio.com/](https://code.visualstudio.com/)}

Most of our instructors will use VSCode during their tutorials. The VSCode website is fairly well documented. If you are on MacOS and have Homebrew you can simply run

```bash
brew install --cask visual-studio-code
```

## Juliaup
\tldr{Install `juliaup` from [julialang.org/install](https://julialang.org/install/)}

The most natural starting point to install Julia onto your system is the [Julia downloads page](https://julialang.org/downloads/), which will tell you to use [`juliaup`](https://github.com/JuliaLang/juliaup).

1. Windows users can download Julia and `juliaup` together from the [Windows Store](https://www.microsoft.com/store/apps/9NJNWW8PVKMN).
2. OSX or Linux users can execute the following terminal command:

```bash
curl -fsSL https://install.julialang.org | sh
```

In both cases, this will make the `juliaup` and `julia` commands accessible from the terminal (or Windows Powershell).
On Windows this will also create an application launcher.
All users can start Julia by running

```bash
julia
```

Meanwhile, `juliaup` provides [various utilities](https://github.com/JuliaLang/juliaup#using-juliaup) to download, update, organize and switch between different Julia versions.
As a bonus, you no longer have to manually specify the path to your executable.
This all works thanks to adaptive shortcuts called "channels", which allow you to access specific Julia versions without giving their exact number.

For instance, the `release` channel will always point to the [current stable version](https://julialang.org/downloads/#current_stable_release), and the `lts` channel will always point to the [long-term support version](https://julialang.org/downloads/#long_term_support_release).
Upon installation of `juliaup`, the current stable version of Julia is downloaded and selected as the default.

\advanced{

To use other channels, add them to `juliaup` and put a `+` in front of the channel name when you start Julia:

```bash
juliaup add lts
julia +lts
```

You can get an overview of the channels installed on your computer with

```bash
juliaup status
```

When new versions are tagged, the version associated with a given channel can change, which means a new executable needs to be downloaded.
If you want to catch up with the latest developments, just do

```bash
juliaup update
```
}

## Test your Julia install
Run this little program 😊:
```julia
println.(1:10 .|>_->prod(j->rand(["╱╲"...]),1:10));
```

## Julia + VSCode
\tldr{Check out the [Julia extension docs](https://www.julia-vscode.org/docs/dev/gettingstarted/#Installation-and-Configuration-1)}


# Workflow

Julia supports a wide-range of workflows, although it is unique in the popularity of "REPL-driven development".
