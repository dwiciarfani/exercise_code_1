with report_to_count as (
select ReportsTo as id,
count(distinct EmployeeID) cnt_team
from Employee 
where ReportsTo is not null
group by 1
),
data_summary as (
select e.EmployeeId ,
e.FirstName ,
e.LastName ,
e.Title ,
COALESCE (r.cnt_team,0) as num_team
from Employee e
left join report_to_count r on e.EmployeeId = r.id
where r.cnt_team > 0
)
select *
from data_summary
order by 5 desc