---
title: 
---

<CalendarHeatmap 
    data={entry}
    date=datum
    value=welbevindenVandaag
    title="Welbevinden"
    subtitle="Dagelijks persoonlijk cijfer (schaal 1-10)" 
/>


<ECharts config={
    {
      title: {
        text: 'Thema van de dag',
        left: 'center'
      },
        tooltip: {
            formatter: '{b}: {c}'
        },
      series: [
        {
          type: 'treemap',
          visibleMin: 4,
          label: {
            show: true,
            formatter: '{b}'
          },
          itemStyle: {
            borderColor: '#fff'
          },
          roam: false,
          nodeClick: false,
          data: [...themas],
          breadcrumb: {
            show: false
          }
        }
      ]
    }
  }
/>

<ECharts config={
    {
      title: {
        text: 'Tools gebruikt',
        left: 'center'
      },
        tooltip: {
            formatter: '{b}: {c}'
        },
      series: [
        {
          type: 'treemap',
          visibleMin: 4,
          label: {
            show: true,
            formatter: '{b}'
          },
          itemStyle: {
            borderColor: '#fff'
          },
          roam: false,
          nodeClick: false,
          data: [...tools],
          breadcrumb: {
            show: false
          }
        }
      ]
      }
    }
/>




```sql entry
  select
      *
  from needful_things.entry
```

```sql tools
select toolsVanDeDag as name, 
  count(*) as value
  
  from needful_things.toolsVanDeDagLong

group by toolsVanDeDag
order by count(*) desc
```

```sql themas
select themasVanVandaag as name, 
  count(*) as value
  
  from needful_things.themasVanVandaagLong

group by themasVanVandaag
order by count(*) desc
```

