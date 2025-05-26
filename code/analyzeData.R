source(here::here("code", "wrangleData.R"))
library(tidytext)

# Herziening thema en tools van de dag categorisering

sort(unique(themasVanVandaagLong$themasVanVandaag))
sort(unique(toolsVanDeDagLong$toolsVanDeDag))


# Text analysis

# De twee variabelen met ongestructureerde tekst zijn:

todo$titel
todo$omschrijving

# ... to do ...
## check wat de ellmer webpagina zegt: 
## https://ellmer.tidyverse.org/articles/structured-data.html#example-4-text-classification
library(ellmer)
ch <- chat_openai(model = "gpt-4o-mini")

ch$chat("When was R created? Be brief.")




