# Take some pictures of the demographics charts



# age group, tests, deaths bubble chart
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-bubble.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-bubble.png"),
                 delay = 5)

# age group cases per 1000 heatmap
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/heat-cap.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/heat-cap.png"),
                 delay = 5)

# age group cases heatmap
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/heat-cases.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/heat-cases.png"),
                 delay = 5)

# age group, deaths, facetted line chart
webshot::webshot(glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-deaths.html"),
                 file = glue("{rprojroot::find_rstudio_root_file()}/images/demographics/age-deaths.png"),
                 delay = 5)