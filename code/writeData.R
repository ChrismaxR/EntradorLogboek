# Bronbestanden en scripts laden ------------------
# • Laadt het dataverwerkingsscript inkomsten.R
# • Activeert DuckDB library (duckdb)

source(here::here("code", "wrangleData.R"))
library(duckdb)
insert_time <- Sys.time() # tijd van het runnen van het script

# Databaseconnectie opzetten ---------------------
# • Maakt verbinding met DuckDB-database needful_things.duckdb
con <- dbConnect(
  drv = duckdb(),
  dbdir = here::here(
    "logboekDashboard",
    "sources",
    "needful_things",
    "needful_things.duckdb"
  )
)

# Meta data tabel voor laatste update date bij te houden
## tabel maken om naar de database te sturen om brondata kwaliteit in de gaten te houden
source_data_meta <- map_df(
  .x = fs::dir_ls(here::here("data"), regex = "_Uren.csv$|financial.csv$"),
  .f = fs::file_info
) |>
  transmute(
    update_date_time = insert_time,
    path = as.character(path),
    birth_date_time = birth_time,
    acces_date_time = access_time,
    change_date_time = change_time
  )

# tabel voor checken van meta gegevens van wrangled data
wrangle_data_meta <- tibble::tibble(
  update_date_time = insert_time,
  fin_long_rows = nrow(fin_long),
  fin_long_cols = ncol(fin_long),
  fin_wide_rows = nrow(fin_wide),
  fin_wide_cols = ncol(fin_wide)
)

# Data schrijven naar DuckDB --------------------
# • Overschrijft bestaande tabellen volledig (overwrite = TRUE)

dbWriteTable(con, "entry", entry, append = F, overwrite = T)
dbWriteTable(con, "todo", todo, append = F, overwrite = T)
dbWriteTable(con, "themasVanVandaagLong", themasVanVandaagLong, append = F, overwrite = T)
dbWriteTable(con, "toolsVanDeDagLong", toolsVanDeDagLong, append = F, overwrite = T)
dbWriteTable(con, "devOpsTracker", devOpsTracker, append = F, overwrite = T)
dbWriteTable(con, "locatieData", locatieData, append = F, overwrite = T)


# Data controleren --------------------------
# • Manuele controle met dbReadTable om te verifiëren of data correct geladen is

dbReadTable(conn = con, "entry")
dbReadTable(conn = con, "todo")
dbReadTable(conn = con, "themasVanVandaagLong")
dbReadTable(conn = con, "toolsVanDeDagLong")
dbReadTable(conn = con, "devOpsTracker")
dbReadTable(conn = con, "locatieData")

# Databaseconnectie sluiten -------------------
# • Sluit de verbinding met DuckDB na afronding werkzaamheden

dbDisconnect(con)

# Rscript voor create tables in het schema -----------------
# source(here::here("code", "duckdb_utils.R"))
