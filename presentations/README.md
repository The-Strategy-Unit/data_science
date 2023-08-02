# Presentations

All presentations use the same general format, using the `su_presentations.scss` file. To create a new presentation,
you must follow these steps:

1. create a folder for your presentation and name it `YYYY-MM-DD_presentation-name`
2. inside this folder, create a file `index.qmd`. this file must be named all in lowercase.
3. start your slides with the following:

```
---
title: "TITLE"
subtitle: "SUBTITLE"
author: "[NAME](mailto:EMAIL)"
date: YYYY-MM-DD
date-format: "MMM D, YYYY"
format:
  revealjs:
    theme: [default, ../su_presentation.scss]
    transition: none
    chalkboard:
      buttons: false
    preview-links: auto
    slide-number: false
    auto-animate: true
    footer: |
      view slides at [the-strategy-unit.github.io/data_science/presentations][ds_presentations]
---

[ds_presentations]: https://the-strategy-unit.github.io/data_science/presentations/YOUR_PRESENTATIONS_FOLDER/
```

Make sure to update the relevant parts above. If you do not wish to use a subtitle, then delete it. You can also not
include your name as a clickable email link by just entering your NAME for the author.

The generic footer link should be updated by changing the ds_presentations reference which follows just after the yaml
header. It's often a good idea though to create a [tinyurl](https://tinyurl.com/app) for the link, and then change the
link to be something easy for users to type in (for example, see `2023-07-11_haca-nhp-demand-model`'s yaml header).

You can change the default height and width of the slides, for example to 1080p by adding:

```
format:
  revealjs:
    ...
    height: 1080
    width: 1920
```

This may be good for online when you are screen sharing, but less good for in-person presentations.

You can also add multiple authors, like so:

```
author:
  - Person 1
  - Person 2
```