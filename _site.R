

## knitr options I want set as default for all ('global') code chunks
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)

# renv uninstalled it when I did a snapshot I think because it's only called from inside glue braces. So, maybe it doesn't recognize it.
library(rprojroot)