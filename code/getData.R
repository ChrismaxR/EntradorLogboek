library(tidyverse)
library(googlesheets4)
library(duckdb)

#googlesheets4::gs4_auth()

logboek <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1nI4tfISEZRjN999LiIkopPa48OYJQoAE5w1x44PnPUc/edit?resourcekey=&gid=366955100#gid=366955100"
) |>
  janitor::clean_names()
