# Take some pictures of the demographics charts

library(glue)

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