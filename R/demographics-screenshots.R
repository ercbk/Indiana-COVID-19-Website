# Take some pictures of the demographics charts

library(glue); library(dplyr)

today <- lubridate::today()

# age group, tests, deaths bubble chart
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-bubble.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/med-age-bubble-{today}.png"),
                 delay = 5)

# age group cases per 1000 heatmap
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/heat-cap.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/cases-heat-cap-{today}.png"),
                 delay = 5)

# age group cases heatmap
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/heat-cases.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/cases-heat-cases-{today}.png"),
                 delay = 5)

# age group, deaths, facetted line chart
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-deaths.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-deaths-line-{today}.png"),
                 delay = 5)


# garbage collection

png_files <- tibble::tibble(paths = fs::dir_ls(glue::glue("{rprojroot::find_rstudio_root_file()}/images/demographics"), regexp = "png")) %>% 
  mutate(
    chart = stringr::str_extract(paths,
                                 pattern = "[a-z]*-[a-z]*-[a-z]*"),
    date = stringr::str_extract(paths,
                                pattern = "[0-9]{4}-[0-9]{2}-[0-9]{2}") %>%
      as.Date()
  )

# clean-up old pngs and extraneous html output
png_files %>% 
  group_by(chart) %>% 
  add_count() %>% 
  filter(n > 7) %>%
  filter(date == min(date)) %>% 
  pull(paths) %>% 
  fs::file_delete(.)

# only need the md file for github
fs::file_delete(glue::glue("{rprojroot::find_rstudio_root_file()}/README.html"))


html_files <- fs::dir_ls(glue::glue("{rprojroot::find_rstudio_root_file()}/images/demographics"), regexp = "html")

artifacts <- fs::dir_ls(glue::glue("{rprojroot::find_rstudio_root_file()}/images/demographics"), regexp = "files")


# delete artifacts and html files that were created during the process
fs::file_delete(c(html_files, artifacts))
