/*________________PROCEDURE________________*/
/*QUESTION_1*/
create or replace procedure warehouse_ajout(x in locations.location_id%type) 
is
v_city locations.city%type;
v_location_id number;
i number:=0;

begin

for vv_location_id in (select * from locations where location_id=x) loop
    if vv_location_id.location_id=x then 
    i:=i+1;
    end if;
end loop;

if i=0 then
    dbms_output.put_line('location non existante !!!');
else

    select count (location_id) into v_location_id from warehouses where location_id=x;
    if v_location_id>0 then
        dbms_output.put_line('warehouse déja existante !!!');
    else
        select city into v_city from locations where location_id=x;
        insert into warehouses(warehouse_name,location_id) values(v_city,x);
    end if;

end if;
end warehouse_ajout;

execute warehouse_ajout(1000);

/*QUESTTION_2*/
create or replace procedure warehouse_ajout(x in locations.location_id%type, vv_city locations.city%type) 
is
v_city locations.city%type;
v_location_id number;
i number:=0;

begin

for vv_location_id in (select * from locations where location_id=x) loop
    if vv_location_id.location_id=x then 
    i:=i+1;
    end if;
end loop;

if i=0 then 
    dbms_output.put_line('location non existante !!!');
else

    select count (location_id) into v_location_id from warehouses where location_id=x;
    if v_location_id=0 then
        dbms_output.put_line('warehouse non existante !!!');
    else
        update warehouses set  warehouse_name=vv_city where location_id=x;
    end if;

end if;
end warehouse_ajout;

execute warehouse_ajout(10000,'hey');

/*QUESTION_3*/
create or replace procedure warehouse_ajout(x in warehouses.warehouse_id%type) 
is
v_city locations.city%type;
v_location_id number;
i number:=0;

begin
    select count (*) into v_location_id from warehouses where warehouse_id=x;
    if v_location_id=0 then
        dbms_output.put_line('warehouse non existante !!!');
    else
        delete from warehouses where warehouse_id=x;
    end if;

end warehouse_ajout;

execute warehouse_ajout(11);

/*QUESTION_4*/
create or replace procedure warehouse_ajout(x in locations.location_id%type) 
is
v_city locations.city%type;
v_location_id number;
i number:=0;
name_warehouse warehouses.warehouse_name%type;

begin


    select count (*) into v_location_id from warehouses where warehouse_id=x;
    if v_location_id=0 then
        dbms_output.put_line('warehouse non existante !!!');
    else
    select warehouse_name into name_warehouse from warehouses where location_id=x;
        dbms_output.put_line('warehouse name : '|| name_warehouse);

    end if;

end warehouse_ajout;

execute warehouse_ajout(5);

/*QUESTION_5*/
create or replace procedure warehouse_ajout(x in employees.employee_id%type) 
is
ca number:=0;
begin

for v_par1 in (select order_id from orders where salesman_id=x) loop
    for v_part2 in (select * from order_items where v_par1.order_id=order_id) loop
        ca:=ca+v_part2.quantity*v_part2.unit_price;
    end loop;
end loop;

dbms_output.put_line('le chiffre d affaire de employe '|| x ||' est : '|| ca);
end warehouse_ajout;

execute warehouse_ajout(54);

/*________________FUNCTION________________*/
/*QUESTION_1*/
create or replace function prix_commande(x in customers.customer_id%type) return number
is
ca number:=0;
begin

for v_par1 in (select order_id from orders where customer_id=x) loop
    for v_part2 in (select * from order_items where v_par1.order_id=order_id) loop
        ca:=ca+v_part2.quantity*v_part2.unit_price;
    end loop;
end loop;

return ca;
end;

begin
dbms_output.put_line('le prix total de la commande du client  est : '|| prix_commande(1));
end;

/*QUESTION_2*/
create or replace function nbr_commande return number
is
ca number:=0;
begin

select count (*) into ca from orders where status='Pending';
return ca;
end;

begin
dbms_output.put_line('le nbr de commandes est : '|| nbr_commande);
end;

/*________________declancheurs________________*/
/*QUESTION_1*/
create or replace trigger resume_order
after insert on order_items
for each row
begin
    dbms_output.put_line('order id : ' || :new.order_id ||
                                    '\n item id : ' || :new.item_id ||
                                    ' product id : ' || :new.product_id ||
                                    ' quantity : ' || :new.quantity ||
                                    ' unit price : ' || :new.unit_price);
end;
/*QUESTION_2*/
set SERVEROUTPUT ON;
create or replace NONEDITIONABLE trigger nbr_invent
after insert on inventories
for each row
begin
    if(:new.quantity < 10) then
    dbms_output.put_line('le nomre d article < 10 ');
    else
    dbms_output.put_line('le nomre d article > 10 ');
    end if;
end;
/*QUESTION_3*/
set SERVEROUTPUT ON;
create or replace trigger credit_erreur
after update on customers
for each row
declare
v_date number := extract(day from sysdate);
begin
    if(v_date >28 and v_date<30) then
    raise_application_error(-20100,'erreur de modification');
    else
    dbms_output.put_line('modification avec succes');
    end if;
end;
/*QUESTION_4*/
set SERVEROUTPUT ON;
create or replace trigger hire_erreur
after insert on employees
for each row
declare
v_date date := sysdate;
begin
    if(:new.hire_date>v_date) then
    raise_application_error(-20101,'erreur d ajout');
    else
    dbms_output.put_line('ajout avec succes');
    end if;
end;
/*QUESTION_5*/
set SERVEROUTPUT ON;
create or replace trigger remise
after insert on order_items
for each row
begin
    if(:new.quantity*:new.unit_price > 10000) then
    dbms_output.put_line('vous avez une remise de 5%');
    else
    dbms_output.put_line('commande avec succes');
    end if;
end;
