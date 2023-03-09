## Data science team repo

This repo features:

* Presentations the team have delivered
* A website/ blog that the data science team can use to blog and compile other forms of resources

We expect it to feature:
* A Quarto presentation theme that conforms to SU branding

We may end up splitting off some of these elements to make them easier to deploy, we haven't quite thought it through yet. If stuff does move around we'll update the README

## How to create a new presentation

* Make a branch
* Make the presentation with quarto, and put it in `presentations/` in a `YYYY-MM-DD_Talk-title` folder
* Add a link to the presentation folder in the bulleted list in the `index.qmd` file in presentations:
  * `* presentations/YYYY-MM-DD_Talk-title`
 * Make a pull request to main
 * The Quarto will be rendered by a GitHub action to [the presentation section of the website](https://the-strategy-unit.github.io/data_science/presentations/)

Please note this project uses renv. On Windows, I needed to install the R toolchain [RTools](https://cran.r-project.org/bin/windows/Rtools/) to compile some of the packages
