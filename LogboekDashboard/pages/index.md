---
title: Mijn todo's van vandaag
---

<Value data={updateDate} column=maxUpdateDate/>

{#each last_todo as todo_loop}

<Details title={todo_loop.header} open=TRUE>

<Value data={todo_loop} column=omschrijving/>

</Details>


{/each}




```sql last_todo
select concat(titel, ' - ', type, ' - ', devOpsId) as header,
       omschrijving
  from needful_things.todo
 where entryId = (select max(entryId) from todo)
```

```sql updateDate
select max(updateDate) as maxUpdateDate
from needful_things.metaData
```