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

objects <- mget(ls())

metaData <- imap_dfr(
  .x = mget(ls()), 
  .f = \(x, y) {
    tibble(
      object = y,
      cols = if (is.data.frame(x) || is.matrix(x)) ncol(x) else NA, 
      rows = if (is.data.frame(x) || is.matrix(x)) nrow(x) else NA,
      updateDate = Sys.Date()
    )
  }
) |> 
  na.omit()

# Data schrijven naar DuckDB --------------------
# • Overschrijft bestaande tabellen volledig (overwrite = TRUE)

dbWriteTable(con, "entry", entry, append = F, overwrite = T)
dbWriteTable(con, "todo", todo, append = F, overwrite = T)
dbWriteTable(con, "themasVanVandaagLong", themasVanVandaagLong, append = F, overwrite = T)
dbWriteTable(con, "toolsVanDeDagLong", toolsVanDeDagLong, append = F, overwrite = T)
dbWriteTable(con, "devOpsTracker", devOpsTracker, append = F, overwrite = T)
dbWriteTable(con, "locatieData", locatieData, append = F, overwrite = T)
dbWriteTable(con, "metaData", metaData, append = F, overwrite = T)


# Data controleren --------------------------
# • Manuele controle met dbReadTable om te verifiëren of data correct geladen is

dbReadTable(conn = con, "entry")
dbReadTable(conn = con, "todo")
dbReadTable(conn = con, "themasVanVandaagLong")
dbReadTable(conn = con, "toolsVanDeDagLong")
dbReadTable(conn = con, "devOpsTracker")
dbReadTable(conn = con, "locatieData")
dbReadTable(conn = con, "metaData")

# Databaseconnectie sluiten -------------------
# • Sluit de verbinding met DuckDB na afronding werkzaamheden

dbDisconnect(con)

# Rscript voor create tables in het schema -----------------
# source(here::here("code", "duckdb_utils.R"))
