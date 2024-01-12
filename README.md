## Data science team repo

This repo features:

* Presentations the team have delivered
* A website/ blog that the data science team can use to blog and compile other forms of resources

We expect it to feature:
* A Quarto presentation theme that conforms to SU branding

## Contributing to this repo

* Request access from a member of the Data Science team, they need to add you as a contributor
* Create an issue for the thing you want to add on GitHub
* Clone the repository (in RStudio, File > New Project > Checkout a project from a version controlled repository). Paste in the URL of this repository
* Check out the main branch and check it's up to date in the RStudio Terminal  (type `git checkout main && git pull` in terminal)
* Check out a new branch  (`git checkout -b issue-number` in terminal)

Please note this project uses renv. On Windows, I needed to install the R toolchain [RTools](https://cran.r-project.org/bin/windows/Rtools/) to compile some of the packages

## How to create a new presentation

* Make the presentation with quarto, and put it in `presentations/` in a `YYYY-MM-DD_Talk-title` folder
* Add a link to the presentation folder in the bulleted list in the `index.qmd` file in presentations:
  * `* presentations/YYYY-MM-DD_Talk-title`
 * Make a pull request to main
 * The Quarto will be rendered by a GitHub action to [the presentation section of the website](https://the-strategy-unit.github.io/data_science/presentations/)

## How to create a new blogpost 

* Navigate to the `blogs/posts` folder
* Copy a previous blogpost file and use that as your template
* If you want to see how it looks before pushing to GitHub, click Render in RStudio
* When finished, save, push your content to your branch in GitHub (`git push origin branchname`). 
* Then, on GitHub, make a pull request to main. Put any member of the Data Science team down as a reviewer. Link your pull request with your issue by typing `Closes #issuenumber` in the comment field.
* When approved and merged to main, the Quarto page will automatically be rendered thanks to the GitHub action that has been set up.
