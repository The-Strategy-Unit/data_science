# running this will generate the trust.geojson file

library(httr)
library(dplyr)
library(purrr)

req <- GET(
  "https://directory.spineservices.nhs.uk",
  path = c(
    "ORD",
    "2-0-0",
    "organisations"
  ),
  query = list(
    Limit = 1000,
    PrimaryRoleId = "RO197"
  )
)

req |>
  content() |>
  pluck("Organisations") |>
  bind_rows() |>
  janitor::clean_names() |>
  filter(status == "Active") |>
  select(name, org_id, post_code) |>
  geocode(postalcode = "post_code") |>
  st_as_sf(coords = c("long", "lat"), crs = 4326) |>
  st_write(
    trusts,
    "presentations/2023-08-24_coffee-and-coding_geospatial/trusts.geojson"
  )
