

drop table if exists Q4_data;
create table Q4_data
(
	id int, 
	name varchar(20),
	location varchar(20)
);
insert into Q4_data values(1, null, null), (2,'David',null), (3,null,'London'),(4,null,null),(5,'David',null);
select * from Q4_data;
--select * from Q4_data;
--select top 1 name from Q4_data where name is not null
--select top 1 id from Q4_data
--select location from Q4_data where location is not null

-----------------------------------------------SOLUTION 1 -----------------------------------------------------------------------------------------
select * from (select top 1 id from Q4_data) id 
cross join (select top 1 name from Q4_data where name is not null) name
cross join (select location from Q4_data where location is not null) location 

select * from (select top 1 id from Q4_data order by id desc) id 
cross join (select top 1 name from Q4_data where name is not null) name
cross join (select location from Q4_data where location is not null) location 

------------------------------------------------SOLUTION 2 -----------------------------------------------------------------------------------------
select min(id) as id ,min(name) as name , max(location) as location
from Q4_data;

select max(id) as id ,max(name) as name , max(location) as location
from Q4_data;