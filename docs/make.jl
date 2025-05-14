using Documenter
using MDSh5

makedocs(;
    modules=[MDSh5],
    format=Documenter.HTML(),
    sitename="MDSh5",
    checkdocs=:none,
)

deploydocs(;
    repo="github.com/anchal-physics/MDSh5.jl.git",
    target="build",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "v#.#"],
)
