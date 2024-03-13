# in the rebuild_site action there is a list of system dependencies that need
# to be installed. the following script uses posit public package manager to
# find the system dependencies for the installed packages in renv

# hopefully one day setup-renv will do this for us...

library(tidyverse)
library(jsonlite)
library(httr)

packages <- read_json("renv.lock") |>
  _$Packages |>
  names() |>
  map(\(.x) {
    httr::GET(
      "https://packagemanager.rstudio.com",
      path = c(
        "__api__",
        "repos",
        "1",
        "sysreqs"
      ),
      query = list(
        all = "false",
        distribution = "ubuntu",
        release = "22.04",
        pkgname = .x
      )
    ) |>
      httr::content() |>
      _$requirements |>
      map(pluck, "requirements", "install_scripts") |>
      purrr::flatten() |>
      flatten_chr()
  }) |>
  flatten_chr() |>
  unique() |>
  sort()

paste0(
  "sudo apt update\n",
  paste(
    "sudo",
    stringr::str_remove(packages, "-get"),
    collapse = "\n"
  )
) |> clipr::write_clip()
