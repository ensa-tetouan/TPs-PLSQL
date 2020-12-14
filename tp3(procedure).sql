--------Procédure--------
 Question :1
create or replace NONEDITIONABLE PROCEDURE add_warehouses(v_location IN LOCATIONS.LOCATION_ID%TYPE )IS
v_city WAREHOUSES.WAREHOUSE_NAME%TYPE;
v1_nbr number;
v_nbr number;
BEGIN
select count(*)into v1_nbr from LOCATIONS where LOCATION_ID=v_location;
if (v1_nbr =1)then
select CITY into v_city from locations where LOCATION_ID=v_location;
select count(*)into v_nbr from WAREHOUSES where LOCATION_ID=v_location;
if (v_nbr =0)then
insert into WAREHOUSES (WAREHOUSE_NAME,LOCATION_ID) values (v_city,v_location);
end if;
end if;
end add_warehouses;

Question :2
create or replace NONEDITIONABLE PROCEDURE update_warehouses(v_location IN LOCATIONS.LOCATION_ID%TYPE,new_name_city IN WAREHOUSES.WAREHOUSE_NAME%TYPE)IS
cmpt number:=0;
BEGIN
for v_warehouses in (select * from WAREHOUSES)loop
if v_warehouses.LOCATION_ID=v_location then
cmpt:=cmpt+1;
end if;
end loop;
if(cmpt=1)then
update WAREHOUSES set WAREHOUSE_NAME=new_name_city where LOCATION_ID=v_location;
dbms_output.put_line('salam');
end if;
end update_warehouses;

Question :3
create or replace NONEDITIONABLE PROCEDURE delete_warehouses(v_location IN LOCATIONS.LOCATION_ID%TYPE)IS
cmpt number:=0;
BEGIN
for v_warehouses in (select * from WAREHOUSES)loop
if v_warehouses.LOCATION_ID=v_location then
cmpt:=cmpt+1;
end if;
end loop;
if(cmpt=1)then
delete from WAREHOUSES where LOCATION_ID=v_location;
end if;
end delete_warehouses;

Question :4
create or replace NONEDITIONABLE PROCEDURE affiche_warehouses(v_location IN LOCATIONS.LOCATION_ID%TYPE)IS
cmpt number:=0;
v_name_warehouses WAREHOUSES.WAREHOUSE_NAME%TYPE; 
BEGIN

for v_warehouses in (select * from WAREHOUSES)loop
if v_warehouses.LOCATION_ID=v_location then
cmpt:=cmpt+1;
end if;
end loop;
if(cmpt=1)then
select WAREHOUSE_NAME into v_name_warehouses from WAREHOUSES where LOCATION_ID=v_location;
dbms_output.put_line('les warehouses ' ||v_name_warehouses);
end if;
end affiche_warehouses;

Question :5
create or replace NONEDITIONABLE PROCEDURE calcule_CA(v_employe IN EMPLOYEES.EMPLOYEE_ID%TYPE)IS
v_CA ORDER_ITEMS.UNIT_PRICE%type:=0;
v_price ORDER_ITEMS.UNIT_PRICE%type;
v_quatity ORDER_ITEMS.QUANTITY%type;
BEGIN
for v_sales in (select * from ORDERS where SALESMAN_ID=v_employe)loop
select sum(UNIT_PRICE*QUANTITY) into v_CA from ORDER_ITEMS where ORDER_ID=v_sales.ORDER_ID;
--v_CA:=v_CA+(v_price*v_quatity);
end loop;
dbms_output.put_line('le chiffre d affaire est '||v_CA);
end calcule_CA;

--------Fonction--------
Question :1
create or replace NONEDITIONABLE FUNCTION prix_totale(v_costumer IN ORDERS.CUSTOMER_ID%TYPE)
RETURN ORDER_ITEMS.UNIT_PRICE%type IS
v_CA ORDER_ITEMS.UNIT_PRICE%type:=0;
BEGIN
for v_sales in (select * from ORDERS where CUSTOMER_ID=v_costumer)loop
select sum(UNIT_PRICE*QUANTITY) into v_CA from ORDER_ITEMS where ORDER_ID=v_sales.ORDER_ID;
--v_CA:=v_CA+(v_price*v_quatity);
end loop;
dbms_output.put_line('le chiffre d affaire est '||v_CA);
return v_CA;
end ;

Question :2
create or replace  FUNCTION pending
RETURN number IS
v_CA number:=0;
BEGIN

select count(*) into v_CA from ORDERS where STATUS='Pending';
--dbms_output.put_line('le chiffre d affaire est '||v_CA);
return v_CA;
end ;
-------DECLENCHEUR---------
Question :1
create or replace NONEDITIONABLE trigger resume_orders 
before insert on ORDER_ITEMS
for each row
begin
 DBMS_OUTPUT.PUT_LINE('my orders is order_id: '||:NEW.ORDER_ID
                               ||'PRODUCT_ID: '||:NEW.PRODUCT_ID||
                                 'QUANTITY  : '||:NEW.QUANTITY||
                                 'UNIT_PRICE  :'||:NEW.UNIT_PRICE);
END;

Question :2
create or replace NONEDITIONABLE trigger alerte_inventaire
after insert or update ON INVENTORIES
for each row
WHEN (new.QUANTITY < 10)
begin
DBMS_OUTPUT.PUT_LINE('*****ALERTE****
        la quantité du stock est inferieure à 10');
END;

Question :3
create or replace trigger credit_limit
after update on CUSTOMERS
for each row
when (extract(day from sysdate)>28 and extract(day from sysdate)<30) 
begin
raise_application_error(-20010,'modification impossible');
end;

Question :4
create or replace trigger interdir_ajout
after insert on employees
for each row
when (new.HIRE_DATE>sysdate)
begin
raise_application_error(-20010,'interdiction d ajouter l employer');
end;

Question :5
create or replace trigger remise
after insert ON ORDER_ITEMS
for each row
WHEN ( new.QUANTITY * new.UNIT_PRICE > 10000)
begin
dbms_output.put_line('Vous beneficiez d une remise de 5%');
END;



