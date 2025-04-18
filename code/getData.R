library(tidyverse)
library(googlesheets4)
library(duckdb)

#googlesheets4::gs4_auth()

logboek <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1O1CbLbCjwRY0UyhB2xkfvPQ22SbQ_JaqG2kW0Lhv70A/edit?resourcekey=&gid=1332128650#gid=1332128650"
) |>
  janitor::clean_names("lower_camel")
