#' Helper functions for purrr-map

#' Convert percent
#' @param raw_staff Tibble containing organisation_name, total and a number of staff categories
#' @return Tibble like raw_staff but with staff categories represented as percentages rather than absolute numbers
convert_percent <- function(staff){
    staff |>
    dplyr::mutate(dplyr::across(.cols = -c(organisation_name, total),
                  .fns =  \(x)x/total)) |>
    dplyr::rename("Doctors" = "hchs_doctors",
                  "Nurses" = "nurses_health_visitors",
                  "Ambulance staff" = "ambulance_staff",
                  "Midwives" = "midwives")
}

#' Plot barchart
#' Makes a bar chart of staff perentages by organisation
#' @param df tibble of staff data in percent format
plot_barchart <- function(df) {
  df |>
    dplyr::filter(organisation_name != "Total") |>
    dplyr::select(-total) |>
    tidyr::pivot_longer(cols = -c(organisation_name), names_to = "job", values_to = "percent") |>
    ggplot2::ggplot(ggplot2::aes(x = percent, y = organisation_name, fill = job)) +
    ggplot2::geom_col(position = "dodge") + 
    ggplot2::scale_x_continuous(labels = scales::percent_format(scale = 100)) +
    ggplot2::labs(x = "", y = "") +
    StrategyUnitTheme::scale_fill_su() + 
    ggplot2::theme_minimal() + 
    ggplot2::theme(legend.title = ggplot2::element_blank())
}

#' Plot waffle
#' Makes a waffle chart to visualise staff breakdown at an ICS level
#' @param raw_staff count data of staff
#' @param title Title for the graphic
plot_waffle <- function(raw_staff, title) {
waffle_data <-
raw_staff |>
    dplyr::filter(organisation_name == "Total") |>
    dplyr::select(-total, -organisation_name) |>
    tidyr::pivot_longer(cols = dplyr::everything(), names_to = "names", values_to = "vals") |>
    dplyr::mutate(vals = round(vals / 100))

ggplot(waffle_data, aes(fill = names, values = vals)) +
  geom_waffle(n_rows = 8, size = 0.33, colour = "white") +
  coord_equal() +
  theme_void() + 
  ggplot2::theme(legend.title = ggplot2::element_blank()) +
  ggplot2::ggtitle(title)
}