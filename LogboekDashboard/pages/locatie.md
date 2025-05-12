---
title: 
---

<BubbleMap 
    data={locatie} 
    lat=long 
    long=lat
    size=dagenOpLocatie 
    value=dagenOpLocatie 
    pointName=locatie 
/>

```sql locatie
select loc.locatie,
  		loc.long,
  		loc.lat,
  		sum(e.todoCount) as sumTodoCount, 
  		count(*) as dagenOpLocatie

  from needful_things.entry e
  left join needful_things.locatieData loc on e.ikWerkteOpDezeLocatie = loc.locatie
group by loc.locatie,
  		loc.long,
  		loc.lat

```