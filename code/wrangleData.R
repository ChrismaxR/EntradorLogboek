# Laad de ruwe data in via een extern R-script
source(here::here("code", "getData.R"))

# Voorbewerken van logboekdata: voeg een unieke ID toe, splits datum/tijd, herorden kolommen
logboek_wrangle <- logboek |>
  mutate(
    entryId = row_number(), # Unieke ID per entry
    datum = date(tijdstempel), # Extract datum uit tijdstempel
    tijdstempel = format(tijdstempel, "%H:%M:%S") # Herformateer tijdcomponent
  ) |>
  select(entryId, datum, tijdstempel, everything()) # Zet ID en tijd vooraan

# Extract en harmoniseer todo-items A t/m D in één dataset
todo <- bind_rows(
  # Todo A
  logboek_wrangle |>
    select(
      entryId,
      datum,
      tijdstempel,
      todoTitel = todoATitel,
      todoOmschrijving = todoAOmschrijving,
      todoDevOps = todoADevOps,
      todoType = todoAType
    ) |>
    mutate(todoVolgorde = "A"),

  # Todo B
  logboek_wrangle |>
    select(
      entryId,
      todoTitel = todoBTitel,
      todoOmschrijving = todoBOmschrijving,
      todoDevOps = todoBDevOps,
      todoType = todoBType
    ) |>
    mutate(todoVolgorde = "B"),

  # Todo C
  logboek_wrangle |>
    select(
      entryId,
      todoTitel = todoCTitel,
      todoOmschrijving = todoCOmschrijving,
      todoDevOps = todoCDevOps,
      todoType = todoCType
    ) |>
    mutate(todoVolgorde = "C"),

  # Todo D
  logboek_wrangle |>
    select(
      entryId,
      todoTitel = todoDTitel,
      todoOmschrijving = todoDOmschrijving,
      todoDevOps = todoDDevOps,
      todoType = todoDType
    ) |>
    mutate(todoVolgorde = "D")
) |>
  filter(!is.na(todoTitel)) |> # Verwijder lege todo-items
  transmute(
    todoId = row_number(), # Unieke ID per todo-item
    entryId,
    devOpsId = as.character(todoDevOps),
    titel = todoTitel,
    type = todoType,
    volgorde = todoVolgorde,
    omschrijving = todoOmschrijving
  )

# Selectie van algemene dagkenmerken per logboekentry
entry <- logboek_wrangle |> 
  mutate(
    welbevindenVandaagBucket = case_when(
      welbevindenVandaag %in% c(1:6) ~ "laag", 
      welbevindenVandaag %in% c(7, 8) ~ "normaal", 
      T ~ "hoog"
    )
  ) |> 
  select(
    entryId,
    datum,
    tijdstempel,
    welbevindenVandaag,
    welbevindenVandaagBucket,
    themasVanVandaag,
    toolsVanDeDag, 
    ikWerkteOpDezeLocatie
  ) |> 
  left_join(
    y = todo |> 
      group_by(entryId) |> 
      summarise(
        todoCount = n()
      ), by = "entryId" 
  )

## themas splitten en long
themasVanVandaagLong <- entry |> 
  select(1, 2, themasVanVandaag) |> 
  mutate(
    themasVanVandaag = str_split(string = themasVanVandaag, pattern = ", ")
  ) |> 
  unnest_longer(themasVanVandaag)

## tools splitten en long
toolsVanDeDagLong <- entry |> 
  select(1, 2, toolsVanDeDag) |> 
  mutate(
    toolsVanDeDag = str_split(string = toolsVanDeDag, pattern = ", ")
  ) |> 
  unnest_longer(toolsVanDeDag)

# DevOpsId tracker - doorlooptijden van DevOps PBI's meten

devOpsTracker <- logboek_wrangle |> 
  select(datum, contains("DevOps")) |> 
  pivot_longer(cols = 2:5) |> 
  na.omit() |> 
  arrange(value, datum) |> 
  select(-name) |> 
  rename(devOpsId = value) |> 
  group_by(devOpsId) |> 
  mutate(
    minmax = case_when(
      datum == max(datum) ~ "maxDatum", 
      datum == min(datum) ~ "minDatum", 
      T ~ NA_character_
    )
  ) |> 
  add_tally(name = "aantalDagenGelogd") |> 
  ungroup() |> 
  na.omit() |> 
  pivot_wider(names_from = minmax, values_from = datum) |> 
  mutate(
    duratie = maxDatum - minDatum
  )
