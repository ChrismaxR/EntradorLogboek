---
title: Mijn historische todo's
---


<DataTable 
    data={historische_todo} 
    search=TRUE 
    rowShading=TRUE 
    rows=100
/>

```sql date_input
select datum from (
  select entry.datum,    
  from needful_things.todo
  left join (
    select entryId, datum from needful_things.entry
  ) as entry on todo.entryId = entry.entryId
)
--group by 1
```


```sql historische_todo
select datum,
       todo.devOpsId,
       todo.titel,
       todo.omschrijving    
       
  from needful_things.todo

left join (select entryId, datum from needful_things.entry) as entry on todo.entryId = entry.entryId
order by 1 desc

```
