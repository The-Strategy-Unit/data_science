# code is commented as we don't want renv trying to detect this package
# it fails to install on github actions

# running this will generate the trust.geojson file

# remotes::install_github("NHS-R-Community/NHSRtools")
# NHSRtools::ods_get_trusts() |>
#   filter(status == "Active") |>
#   select(name, org_id, post_code) |>
#   geocode(postalcode = "post_code") |>
#   st_as_sf(coords = c("long", "lat"), crs = 4326) |>
#   st_write(trusts, "presentations/2023-08-24_coffee-and-coding_geospatial/trusts.geojson")
