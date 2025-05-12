library(duckdb)

# Rscript voor create tables in het schema
# source(here::here("code", "duckdbUtils.R"))

# duckdb inserts voor Evidence dashboard
## set up database connectie
con <- dbConnect(
  drv = duckdb::duckdb(),
  dbdir = here::here(
    "logboekDashboard",
    "sources",
    "needful_things",
    "needful_things.duckdb"
  )
)

# source: https://r.duckdb.org

## set up duckdb tables
### entry tabel:
dbExecute(
  con,
  "CREATE TABLE entry (
    entryId  INTEGER,
    datum  DATE,
    tijdstempel  TIME,
    welbevindenVandaag  INTEGER,
    welbevindenVandaagBucket  TEXT,
    themasVanVandaag  TEXT,
    toolsVanDeDag  TEXT,
    ikWerkteOpDezeLocatie  TEXT, 
    todoCount  INTEGER
  )"
)

## todo tabel:
dbExecute(
  con,
  "CREATE TABLE todo (
    todoId  TEXT,
    entryId  TEXT,
    devOpsId  TEXT,
    titel  TEXT,
    type TEXT,
    volgorde TEXT,
    omschrijving TEXT
  )"
)

## themasVanVandaagLong:
dbExecute(
  con,
  "CREATE TABLE themasVanVandaagLong(
    entryId  TEXT,
    datum  DATE,
    themasVanVandaag  TEXT
  )"
)

## toolsVanDeDagLong:
dbExecute(
  con,
  "CREATE TABLE toolsVanDeDagLong(
    entryId  TEXT,
    datum  DATE,
    toolsVanDeDag  TEXT
  )"
)

## devOpsTracker:
dbExecute(
  con,
  "CREATE TABLE devOpsTracker(
    devOpsId  TEXT,
    aantalDagenGelogd  INTEGER,
    minDatum  DATE,
    maxDatum  DATE,
    duratie  TEXT
  )"
)

## locatieReferentie:
dbExecute(
  con,
  "CREATE TABLE locatieData(
    locatie  TEXT,
    long  DOUBLE,
    lat  DOUBLE
  )"
)

# source_data_meta
dbExecute(
  con,
  "CREATE TABLE source_data_meta (
    update_date_time  DATETIME,
    path  TEXT,
    birth_date_time DATETIME,
    acces_date_time DATETIME,
    change_date_time DATETIME
  )"
)

# Remove tables
# duckdb::dbRemoveTable(con, "wrangle_data_meta")
