drop table if exists mountain_huts;
create table mountain_huts
( id integer not null unique,
name varchar(40) not null unique,
altitude integer not null 
)

insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);

insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);


--select * from mountain_huts;
--select * from trails;

with cte1 as (select t.hut1, m.name as start_spot,m.altitude as start_altitude, t.hut2,ma.name dest_spot , ma.altitude dest_altitude from 
trails t left join mountain_huts m
on t.hut1=m.id 
left join mountain_huts ma
on t.hut2=ma.id),

cte2 as (select *, 
case when start_altitude > dest_altitude then 1 else 0 end as altitude_flag
from cte1),

cte3 as (select 
case when altitude_flag =0 then hut2 else hut1 end as swapped_hut1,
case when altitude_flag =0 then dest_spot else start_spot end as swapped_start_spot,
case when altitude_flag =0 then dest_altitude else start_altitude end as swapped_start_altitude,
case when altitude_flag =0 then hut1 else hut2 end as swapped_hut2,
case when altitude_flag =0 then start_spot else dest_spot end as swapped_dest_spot,
case when altitude_flag =0 then start_altitude  else dest_altitude end as swapped_dest_altitude,
cte2.altitude_flag
from cte2)

--select * from cte3

Select S.swapped_start_spot as Start_Spot, S.swapped_dest_spot as Middle_Dest,  T.swapped_dest_spot as Dest_Sppot from cte3 as S
join cte3 T
on S.swapped_hut2=T.swapped_hut1



