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

# Selectie van algemene dagkenmerken per logboekentry
entry <- logboek_wrangle |>
  select(
    entryId,
    datum,
    tijdstempel,
    welbevindenVandaag,
    themasVanVandaag,
    toolsVanDeDag
  )

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
    entryId,
    todoId = row_number(), # Unieke ID per todo-item
    todoVolgorde,
    todoTitel,
    todoOmschrijving,
    todoDevOps,
    todoType
  )
