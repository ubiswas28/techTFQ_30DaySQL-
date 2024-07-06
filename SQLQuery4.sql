create table calls
( from_id int not null, 
  to_id int not null, 
  duration int 
  );

  insert into calls values (1,2,59),
							(2,1,11),
							(1,3,20),
							(3,4,100),
							(3,4,200),
							(3,4,200),
							(4,3,499)
							
--select * from calls

with cte as(select duration,
case when from_id > to_id then to_id else from_id end as modified_from_id,
case when from_id > to_id then from_id else to_id  end as modified_to_id
from calls)

select modified_from_id,modified_to_id,sum(duration) as total_duration,count(*) as calls_count
from cte  
group by modified_from_id,modified_to_id