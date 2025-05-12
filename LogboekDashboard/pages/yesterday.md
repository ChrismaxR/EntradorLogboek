---
title: Mijn historische todo's
---


<DateInput
    name=historische_datum
    data={date_input}
    dates=datum
/>


{#each historische_todo as todo_loop}

<Details title={todo_loop.header} open=TRUE>

<Value data={todo_loop} column=omschrijving/>

</Details>


{/each}

```sql date_input
select distinct datum from needful_things.entry
```

```sql historische_todo
select concat(todo.titel, ' - ', todo.type, ' - ', todo.devOpsId) as header,
       todo.omschrijving, 
       entry.datum
  from needful_things.todo

left join (select entryId, datum from needful_things.entry) as entry on todo.entryId = entry.entryId

where entry.datum = '${inputs.historische_datum.value}'

```
