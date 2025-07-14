<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Raye Skye Kimmerer"
mintoclevel = 2
maxtoclevel = 2

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = [
    "node_modules/",
    "CONTRIBUTING.md",
    "optimizing",
    "sharing"
]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = false
website_title = "Quantum Numerics Julia Intro"
website_descr = ""
website_url   = "https://modernjuliaworkflows.org/"
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\tldr}[1]{
  @@tldr
  **TLDR**: !#1 
  @@
}

\newcommand{\advanced}[1]{
  @@advanced
  **Advanced**: !#1
  @@
}

\newcommand{\vscode}[1]{
  @@vscode
  **VSCode**: !#1
  @@
}

\newcommand{\important}[2]{
  @@important
  **Important** - **#1**
  #2
  @@
}

\newcommand{\tutorial}[1]{
  *To ensure code in this tutorial runs as shown, download the tutorial [project folder](\tgz{#1})

  \toc\literate{/_literate/!#1/tutorial.jl}
}

\newcommand{\image}[3]{
~~~
<figure style="text-align:center;">
<img src="!#2" style="padding:0;#3" alt="#1"/>
<figcaption>#1</figcaption>
</figure>
~~~
}
\newcommand{\image30}[2]{
~~~
<figure style="text-align:center;">
<img src="!#2" style="padding:0;width:30%" alt="#1"/>
<figcaption>#1</figcaption>
</figure>
~~~
}
