set serveroutput on

/* package specification park */
create or replace package myfunction as

type ref_cursor is ref cursor;

/* answer for question 2, functions to show the tuples in each table */
function show_logs return ref_cursor;
function show_supplies return ref_cursor;
function show_suppliers return ref_cursor;
function show_discounts return ref_cursor;
function show_purchases return ref_cursor;
function show_products return ref_cursor;
function show_employees return ref_cursor;
function show_customers return ref_cursor;

/* answer for question 3, purchase_saving(pur#), to report the total saving of any purchase for any given pur# */
function purchase_saving(pur_no in purchases.pur#%type) return purchases.total_price%type;


/* answer for question 4, a procedure to report the monthly sale activity information for any given employee */
procedure monthly_sale_activities(employee_id in employees.eid%type);
procedure monthly_sale_activities_jdbc(employee_id in employees.eid%type, rc out ref_cursor, status out integer);


/* answer for question 5, a procedure for adding tuples to the Customers table*/
procedure add_customer(c_id in customers.cid%type, c_name in customers.name%type, c_telephone# in  customers.telephone#%type);


/* answer for question 7, a procedure for adding tuples to the Purchases table.*/ 
procedure add_purchase(e_id in purchases.eid%type, p_id in purchases.pid%type, c_id in purchases.cid%type, pur_qty in purchases.qty%type);
procedure add_purchase_jdbc(e_id in purchases.eid%type, p_id in purchases.pid%type, c_id in purchases.cid%type, pur_qty in purchases.qty%type, status out integer); 


/* answer for question 8, a procedure for deleting tuples from the Purchases table to simulate returning purchases by customers.*/ 
procedure delete_purchase(pur_id in purchases.pur#%type);
procedure delete_purchase_jdbc(pur_id in purchases.pur#%type, status out integer);

end;
/
show errors



/* package body part */
create or replace package body myfunction as

/* answer for question 2, functions to show the tuples in logs */
function show_logs
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from logs;
return rc;
end;

/* answer for question 2, functions to show the tuples in supplies */
function show_supplies
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from supplies;
return rc;
end;

/* answer for question 2, functions to show the tuples in suppliers */
function show_suppliers
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from suppliers;
return rc;
end;

/* answer for question 2, functions to show the tuples in discounts */
function show_discounts
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from discounts;
return rc;
end;

/* answer for question 2, functions to show the tuples in purchases */
function show_purchases
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from purchases;
return rc;
end;

/* answer for question 2, functions to show the tuples in products */
function show_products
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from products;
return rc;
end;

/* answer for question 2, functions to show the tuples in employees */
function show_employees
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from employees;
return rc;
end;

/* answer for question 2, functions to show the tuples in customers */
function show_customers
return ref_cursor is
rc ref_cursor;
begin
open rc for
select * from customers;
return rc;
end;


/* answer for question 3, purchase_saving(pur#), to report the total saving of any purchase for any given pur# */
function purchase_saving(pur_no in purchases.pur#%type) 
return purchases.total_price%type is
	pur_saving purchases.total_price%type;
begin
	select p.original_price*g.qty-g.total_price into pur_saving from purchases g, products p where g.pur# = pur_no and g.pid = p.pid;
	return pur_saving;
exception when NO_DATA_FOUND then
	dbms_output.put_line('Invalid pur#.');
	pur_saving := -1;
	return pur_saving;
end;


/* answer for question 4, a procedure to report the monthly sale activity information for any given employee */
procedure monthly_sale_activities(employee_id in employees.eid%type) is
	cursor rc is
	select * from 
		(select eid, name from employees where eid = employee_id) a,  
		(select MON, YEAR, count(*) sales_times,sum(qty) sales_qty, sum(total_price) sales_amount from 
		(select to_char(ptime,'MON') MON, to_char(ptime, 'YYYY') YEAR, qty, total_price from purchases where eid = employee_id) 
		group by MON, YEAR) b;
begin
	dbms_output.put_line( 'eid' || ',' || 'name' || ',' || 'MON' ||',' || 'YEAR' || ',' || 'sales_times' || ',' || 'sales_qty' || ',' || 'sales_amount');
	for c in rc
	loop
		dbms_output.put_line(c.eid || ',' ||c.name || ',' ||c.MON ||',' || c.YEAR || ',' ||c.sales_times || ',' ||c.sales_qty || ',' ||c.sales_amount);
	end loop;
end;


/* answer for question 4, a procedure to report the monthly sale activity information for any given employee, modified procedure for jdbc use */

procedure monthly_sale_activities_jdbc(employee_id in employees.eid%type, rc out ref_cursor, status out integer) is
e_id employees.eid%type;
begin
	open rc for
	select * from 
		(select eid, name from employees where eid = employee_id) a,  
		(select MON, YEAR, count(*) sales_times,sum(qty) sales_qty, sum(total_price) sales_amount from 
		(select to_char(ptime,'MON') MON, to_char(ptime, 'YYYY') YEAR, qty, total_price from purchases where eid = employee_id) 
		group by MON, YEAR) b;

	status := 0;
	select eid into e_id from employees where eid = employee_id;
exception
	when NO_DATA_FOUND then
		status := 1;
end;

/* Method 2 for question 4
procedure monthly_sale_activities(employee_id in employees.eid%type) is 
begin

dbms_output.put_line( 'eid' || ',' || 'name' || ',' || 'MON' ||',' || 'YEAR' || ',' || 'sales_times' || ',' || 'sales_qty' || ',' || 'sales_amount');

for c in ( 
select * from 
(select eid, name from employees where eid = employee_id) a,  
(select MON, YEAR, count(*) sales_times,sum(qty) sales_qty, sum(total_price) sales_amount from 
(select to_char(ptime,'MON') MON, to_char(ptime, 'YYYY') YEAR, qty, total_price from purchases where eid = employee_id) 
group by MON, YEAR) b)

loop
	dbms_output.put_line(c.eid || ',' ||c.name || ',' ||c.MON ||',' || c.YEAR || ',' ||c.sales_times || ',' ||c.sales_qty || ',' ||c.sales_amount);

end loop;

end;


/* answer for question 5, a procedure for adding tuples to the Customers table*/
procedure add_customer(c_id in customers.cid%type, c_name in customers.name%type, c_telephone# in  customers.telephone#%type) is
begin

	insert into customers values (c_id, c_name, c_telephone#, 1, sysdate);

end;


/* answer for question 7, a procedure for adding tuples to the Purchases table.
Purchases(pur#, eid, pid, cid, ptime, qty, total_price)
*/ 
procedure add_purchase(e_id in purchases.eid%type, p_id in purchases.pid%type, c_id in purchases.cid%type, pur_qty in purchases.qty%type) is 

t_price purchases.total_price%type;
qty_limit products.qoh%type;
invalid_qty exception;

begin
	
	select qoh into qty_limit from products where pid = p_id;

	select (p.original_price * (1 - d.discnt_rate)) into t_price from products p, discounts d where p.pid = p_id and p.discnt_category = d.discnt_category;
	t_price := t_price * pur_qty;

	if(pur_qty > qty_limit) then 
		raise invalid_qty;
	else

		insert into purchases values (pur#_seq.nextval, e_id, p_id, c_id, pur_qty, sysdate, t_price);

	end if;

exception
	when invalid_qty then 
		dbms_output.put_line('Insufficient quantity in stock.');

end;

/* answer for question 7, a procedure for adding tuples to the Purchases table, modified procedure for jdbc use.
Purchases(pur#, eid, pid, cid, ptime, qty, total_price)
*/ 
procedure add_purchase_jdbc(e_id in purchases.eid%type, p_id in purchases.pid%type, c_id in purchases.cid%type, pur_qty in purchases.qty%type, status out integer) is 

t_price purchases.total_price%type;
qty_limit products.qoh%type;
invalid_qty exception;
eno employees.eid%type;
pno products.pid%type;
cno customers.cid%type;
threshold products.qoh_threshold%type;

begin
	
	select eid into eno from employees where eid = e_id;
	select cid into cno from customers where cid = c_id;	
	select qoh, pid, qoh_threshold into qty_limit, pno, threshold from products where pid = p_id;

	select (p.original_price * (1 - d.discnt_rate)) into t_price from products p, discounts d where p.pid = p_id and p.discnt_category = d.discnt_category;
	t_price := t_price * pur_qty;

	if(pur_qty > qty_limit) then 
		raise invalid_qty;
	else

		insert into purchases values (pur#_seq.nextval, e_id, p_id, c_id, pur_qty, sysdate, t_price);

	end if;

	status := 0;

	if(qty_limit - pur_qty < threshold) then
		status := qty_limit - pur_qty + threshold + 11 + 1000;
	end if;

exception
	when invalid_qty then 
		dbms_output.put_line('Insufficient quantity in stock.');
		status := 1;
	when NO_DATA_FOUND then
		dbms_output.put_line('Invalid cid, pid or eid.');
		status := 2;

end;

/* answer for question 8, a procedure for deleting tuples from the Purchases table to simulate returning purchases by customers.*/ 
procedure delete_purchase(pur_id in purchases.pur#%type) is 

begin

	delete from purchases where pur# = pur_id;
end;


procedure delete_purchase_jdbc(pur_id in purchases.pur#%type, status out integer) is 
purno purchases.pur#%type;

begin
	select pur# into purno from purchases where pur# = pur_id;
	delete from purchases where pur# = pur_id;
	status := 0;
exception
	when NO_DATA_FOUND then
		status := 1;
end;

end;
/

show errors
