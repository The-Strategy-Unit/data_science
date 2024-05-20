<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-6-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->


# Data science team repo

If you have any questions or need help, please contact anyone from [the Data Science team](https://the-strategy-unit.github.io/data_science/about.html).

This repo features:

* Presentations the team have delivered
* A website/ blog that the data science team can use to blog and compile other forms of resources
* Guidance on good coding practices, also known as a "style guide"

## Contributing to this repo

1. Request access from a member of [the Data Science team](https://the-strategy-unit.github.io/data_science/about.html), they need to add you as a contributor. Alternatively, you can [fork the repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) to your own GitHub account.
2. Create an issue for the thing you want to add on GitHub
3. Clone the repository (in RStudio, File > New Project > Checkout a project from a version controlled repository). Paste in the URL of this repository, or the forked repository if you have forked it.
4. Check out the main branch and check it's up to date in the RStudio Terminal  (type `git checkout main && git pull` in terminal)
5. Check out a new branch  (`git checkout -b issue-number` in terminal)

Please note this project uses {renv}. On Windows, I needed to install the R toolchain [RTools](https://cran.r-project.org/bin/windows/Rtools/) to compile some of the packages. If you have {renv} installed, run `renv::install()` in your Console to install all the packages required by this project to render the Quarto webpage.

### How to create a new presentation

1. Make the presentation with quarto, and put it in `presentations/` in a `YYYY-MM-DD_Talk-title` folder. Your presentation should conform to the SU branding.
2. Add a link to the presentation folder in the bulleted list in the `index.qmd` file in presentations:
  \n `* presentations/YYYY-MM-DD_Talk-title`


### How to create a new blogpost 

1. Navigate to the `blogs/posts` folder
2. Copy a previous blogpost file and use that as your template
3. If you want to see how it looks before pushing to GitHub, click Render in RStudio. The HTML version of your new post should open in your browser.


### How to create/edit pages on the website

1. Find the `.qmd` file that you wish to edit. For example, if you want to add to the Style Guide page, edit the `style/style_guide.qmd` file.
2. If creating a new page, copy an existing `.qmd` file and use that as a template.
3. If you want to see how it looks before pushing to GitHub, click Render in RStudio. The HTML version of your new post should open in your browser.


### Pushing your blog post/presentation/page to GitHub

1. Save your file, then add and commit it (`git add file.qmd` and `git commit -m "Add blog post/presentation about x"`)
2. Push your content to your branch in GitHub (`git push origin branchname`). 
3. Then, on GitHub, make a pull request to main. Put any member of the Data Science team down as a reviewer. Link your pull request with your issue by typing `Closes #issuenumber` in the comment field of your pull request.
4. When approved and merged to main, the Quarto page will automatically be rendered thanks to the GitHub action that has been set up.

# Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://chrisbeeley.net"><img src="https://avatars.githubusercontent.com/u/1259867?v=4?s=100" width="100px;" alt="Chris Beeley"/><br /><sub><b>Chris Beeley</b></sub></a><br /><a href="#talk-ChrisBeeley" title="Talks">📢</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.strategyunitwm.nhs.uk/"><img src="https://avatars.githubusercontent.com/u/105867449?v=4?s=100" width="100px;" alt="Craig Parylo"/><br /><sub><b>Craig Parylo</b></sub></a><br /><a href="#blog-craig-parylo" title="Blogposts">📝</a> <a href="#talk-craig-parylo" title="Talks">📢</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/jacgrout"><img src="https://avatars.githubusercontent.com/u/103451105?v=4?s=100" width="100px;" alt="Jacqueline Grout"/><br /><sub><b>Jacqueline Grout</b></sub></a><br /><a href="#talk-jacgrout" title="Talks">📢</a> <a href="#blog-jacgrout" title="Blogposts">📝</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://matt-dray.com"><img src="https://avatars.githubusercontent.com/u/18232097?v=4?s=100" width="100px;" alt="Matt Dray"/><br /><sub><b>Matt Dray</b></sub></a><br /><a href="#blog-matt-dray" title="Blogposts">📝</a> <a href="#talk-matt-dray" title="Talks">📢</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://tjmt.uk/"><img src="https://avatars.githubusercontent.com/u/12023696?v=4?s=100" width="100px;" alt="Tom Jemmett"/><br /><sub><b>Tom Jemmett</b></sub></a><br /><a href="#blog-tomjemmett" title="Blogposts">📝</a> <a href="#talk-tomjemmett" title="Talks">📢</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://www.linkedin.com/in/yiwen-h/"><img src="https://avatars.githubusercontent.com/u/60136255?v=4?s=100" width="100px;" alt="YiWen Hon"/><br /><sub><b>YiWen Hon</b></sub></a><br /><a href="#blog-yiwen-h" title="Blogposts">📝</a> <a href="#talk-yiwen-h" title="Talks">📢</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
