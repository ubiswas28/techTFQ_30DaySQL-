drop table if exists footer;
create table footer
(
	id int primary key,
	car varchar(20),
	length int, 
	width int, 
	height int
);


INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;


---SOLUTION 2------

SELECT * FROM FOOTER;

select * from 

(select top 1 car from footer where car is not null order by id desc) car 
cross join (select top 1 length from footer where length is not null order by id desc) length
cross join (select top 1 width from footer where width is not null order by id desc) width 
cross join (select top 1 height from footer where height is not null order by id desc) height

---SOLUTION 2------

with cte as (SELECT id,car,length,
sum(case when length is null then 0 else 1 end) over (order by id) as flag_length,
width,
sum(case when width is null then 0 else 1 end) over (order by id) as flag_width,
height,
sum(case when height is null then 0 else 1 end) over (order by id) as flag_height
FROM FOOTER)

select top 1 id,car, first_value(length) over(partition by flag_length order by id) modified_length, 
first_value(width) over(partition by flag_width order by id ) modified_width,
first_value(height) over(partition by flag_height order by id) modified_height
from cte order by id desc 