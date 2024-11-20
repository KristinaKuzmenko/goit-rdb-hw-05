use mydb;

select od.*, 
(select customer_id from orders o 
where o.id = od.order_id) 
as customer_id
from order_details od;

select * from order_details
where order_id in (select id from orders where shipper_id = 3);

select order_id, avg(quantity) 
from (select * from order_details 
      where quantity > 10) 
      as temp_table
group by order_id;

with temp as (
    select * from order_details 
	where quantity > 10)
select order_id, avg(quantity) 
from temp
group by order_id;

drop function if exists custom_func;

delimiter //
create function custom_func (input_1 float, input_2 float)
returns float
deterministic
no sql
begin
    declare result float;
    set result = input_1/input_2;
    return result;
end //

delimiter ;

select quantity, custom_func(quantity, 2.2) from order_details;
