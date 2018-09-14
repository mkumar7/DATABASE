/*
Logs(log#, user_name, operation, op_time, table_name, tuple_pkey)
*/

drop trigger customers_insert;
drop trigger customers_update;
drop trigger purchases_insert;
drop trigger products_update;
drop trigger supplies_insert;
drop trigger purchases_add;
drop trigger purchases_delete;

/* question 6.1 trigger for inserting a tuple into the Customers table;*/
create or replace trigger customers_insert 
after insert on customers
for each row
begin
insert into logs values (log#_seq.nextval, user, 'insert', sysdate, 'customers', :new.cid);
end;
/
show errors

/* question 6.2 trigger for updating the last_visit_date attribute of the Customers table;*/
create or replace trigger customers_update 
after update of last_visit_date on customers
for each row
begin
insert into logs values (log#_seq.nextval, user, 'update', sysdate, 'customers', :old.cid);
end;
/
show errors

/* question 6.3 trigger for inserting a tuple into the Purchases table;*/
create or replace trigger purchases_insert 
after insert on purchases
for each row
begin
insert into logs values (log#_seq.nextval, user, 'insert', sysdate, 'purchases', :new.pur#);
end;
/
show errors

/* question 6.4 trigger for updating the qoh attribute of the Products table;*/
create or replace trigger products_update 
after update of qoh on products
for each row
begin
insert into logs values (log#_seq.nextval, user, 'update', sysdate, 'products', :old.pid);
end;
/
show errors


/* question 6.5 trigger for inserting a tuple into the Supplies table.*/
create or replace trigger supplies_insert 
after insert on supplies
for each row
begin
insert into logs values (log#_seq.nextval, user, 'insert', sysdate, 'supplies', :new.sup#);
end;
/
show errors


/* question 7 trigger for inserting a tuple into the Purchases table;
Supplies(sup#, pid, sid, sdate, quantity)
*/
create or replace trigger purchases_add 
after insert on purchases
for each row
declare
qty products.qoh%type;
lim products.qoh_threshold%type;
squantity supplies.quantity%type;
ssid supplies.sid%type;
today customers.last_visit_date%type;

begin
	update products 
		set qoh = qoh - :new.qty where pid = :new.pid;

	select last_visit_date into today from customers where cid = :new.cid;
	if (to_char(today, 'YYYY') = to_char(sysdate, 'YYYY') and to_char(today, 'MON') = to_char(sysdate, 'MON') and to_char(today, 'DD') = to_char(sysdate, 'DD'))
	then
		NULL;
	else
		update customers
			set visits_made = visits_made + 1 where cid = :new.cid;
		update customers
			set last_visit_date = sysdate where cid = :new.cid;
	end if;
	select qoh, qoh_threshold into qty, lim from products where pid = :new.pid;
	if(qty < lim) then
		dbms_output.put_line('The current qoh of the product is below the required threshold and new supply is required');
		select g into ssid from (select min(sid) g, pid from supplies group by pid) where pid = :new.pid;
		squantity := (lim - qty + 1) + qty + 10;
		insert into supplies values (sup#_seq.nextval, :new.pid,ssid , sysdate, squantity);
		qty := qty + squantity;
		update products 
			set qoh = qty where pid = :new.pid;
		dbms_output.put_line('The new value of qoh after supply is: ' || qty );
	end if;
end;
/

show errors

/* question 8 trigger for deleting tuples from the Purchases table to simulate returning purchases by customers;
Supplies(sup#, pid, sid, sdate, quantity)
*/
create or replace trigger purchases_delete 
after delete on purchases
for each row
declare
today customers.last_visit_date%type;
begin
	update products 
		set qoh = qoh + :old.qty where pid = :old.pid;

	select last_visit_date into today from customers where cid = :old.cid;
	if (to_char(today, 'YYYY') = to_char(sysdate, 'YYYY') and to_char(today, 'MON') = to_char(sysdate, 'MON') and to_char(today, 'DD') = to_char(sysdate, 'DD'))
	then
		NULL;
	else
		update customers
			set visits_made = visits_made + 1 where cid = :old.cid;
		update customers
			set last_visit_date = sysdate where cid = :old.cid;
	end if;

end;
/

show errors
