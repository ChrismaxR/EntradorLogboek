# EntradorLogboek
---
Projectstatus: 🟡 In ontwikkeling  
Auteur: Christian van Gaalen  
Startdatum: April 2025
---- 

## Overzicht

**EntradorLogboek** is een persoonlijk project met als doel het systematisch verzamelen en visualiseren van data over mijn werkzaamheden als Business Analyst bij mijn opdrachtgever. 
Het fungeert als een logboek, reflectietool, en communicatiemiddel in één.

## Doelstellingen

- Verhogen van zelfmotivatie door resultaten inzichtelijk te maken en progressie over tijd te volgen
- Gedetailleerd bijhouden van mijn werkzaamheden als input voor jaargesprekken met mijn werkgever
- Effectiever communiceren over behaalde resultaten
- Ontdekken van patronen en rode draden in mijn werkzaamheden
- Mogelijkheid tot dagelijkse reflectie, eventueel met een subjectieve score (welbevinden)

## Functionele eisen

- **Dagelijkse registratie van taken**: inclusief geplande To Dos en behaalde resultaten. 
- **Dagelijkse check-in reminder**: automatische trigger (bijv. via e-mail), maar wel alleen op de dagen dat ik werk.
- **Lage frictie**: snelle, intuïtieve invoer vereist
- **Verschillende invoervelden**: vrije tekst, numerieke waarden, ordinale waarden
- **Koppeling met documentatie**: eenvoudig linken aan rapportages, user stories, charts, enz.
- **Dashboarding en rapportage**: visualisatie en analyse van verzamelde data (vorm nog nader te bepalen)

## Visualisatieideeën

- Dashboard met kwantitatieve metrics:
  - Aantal geschreven user stories
  - Aantal afgeronde To Do's
  - Gemiddelde welbevinden-score
  - Github-achtige visuals, zoals commit chart en contribution acitivity log
- Taalanalyses:
  - Themas in beschrijvingen van werkzaamheden
  - Groei in kennisdomeinen (proceskennis, organisatie-inzicht)
- Toolgebruik:
  - Visualisatie van gebruikte software en technieken (bv. Figma, Azure DevOps)
- Documentatieweergave:
  - Collages, dumps, storytelling of carrousel-weergaven van gegenereerde kennis en artefacten

## Dagelijkse check-in: initiële ideeën

- **Google Forms**:
  - Dagelijkse e-mail met gepersonaliseerde formulierlink
  - Centrale opslag in Google Sheets
- **Bestaande tools**:
  - Taskwarrior (CLI-gebaseerd)
  - MS Excel (met macros of Forms)
  - Alternatieve apps met API-integraties of automatiseringsopties

## Volgende stappen

1. MVP bouwen voor dagelijkse check-in (via Google Forms of ander lichtgewicht alternatief)
2. Dataverzameling starten
3. Eerste iteratie van dashboard visualisatie ontwerpen (mogelijk met R/Shiny of Power BI)
4. Routinematige koppeling met documentatie en outputs
5. Taalanalyse en verdiepende rapportages verkennen

Sparren met ChatGPT: https://chatgpt.com/share/67f7dca7-8198-8004-bcdc-b892f52cdb22

## MVP - werkende dagelijkse check-in

# Data verzamelen
- Google forms - formulier: https://forms.gle/UoRm5FryiPb2Nuga6
- Google Sheets file: https://docs.google.com/spreadsheets/d/1nI4tfISEZRjN999LiIkopPa48OYJQoAE5w1x44PnPUc/edit?resourcekey=&gid=366955100#gid=366955100
- Google Apps script: https://script.google.com/u/1/home/projects/10nIEo-qq_uN3maOzhGHu1xdNaayj8RzaBh5VWO_f-raFrQEzxcRsUbdh/edit

De wijze waarop data verzamelt wordt kan samengevat worden met de volgende _Activity Diagram_:

![](project/Activity%20Diagram%20EntradorLogboek.png)

Het invullen van de google Form is als volgt te begrijpen:
![](project/Proces%20Flow%20Google%20Forms.png)


# Bevindingen:

1. ~~Verhelder doel van het logboek: iedere ochtend opschrijven wat ik wil doen. Niet vragen wat ik die dag heb gedaan (want weet ik nog niet)~~

2. ~~Nog een beetje een onnatuurlijke vibe bij het beschrijven van elke To do, kan dit makkelijker?~~

3. Neem in de To do vragen ook de verwijzing naar materialen mee. 

4. Dat een item terugkomt na een refinement, omdat het daar niet goed is bevonden, wil ik ook kunnen bijhouden. Hoe bouw ik dit in de Google form het data model?

# Data model idee: 
Initiële idee: https://chatgpt.com/share/67fccf86-b568-8004-9e05-e376bff929d5

![](project/EntradorLogboek%20DataModel.png)

# Doorontwikkeling

In github heb ik een Project aangemaakt met een kanban board om mijn doorontwikkeling te managen:

Zie: https://github.com/users/ChrismaxR/projects/2/views/1?layout=board