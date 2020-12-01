—question 1

declare 
a number ;
b varchar(240) ;
c number ;
r number ;
procedure add_wherehourse (wareid in number,warename in varchar ,local_id in number) IS 
begin
select LOCATION_ID  into r from LOCATIONS  where LOCATION_ID = c ;
if sql%notfound then 
dbms_output.put_line('no such location with this id');
elsif sql%found then 
dbms_output.put_line('costumer found');
Insert into OT.WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (wareid,warename,local_id);
end if ;
end ;
begin
a:= &a ;
b:= '&b' ;
c:= &c ;
add_wherehourse(a,b,c) ;
end ;

—question 2

set serveroutput on ;
declare 
a number ;
b varchar(240) ;
c number ;
r number ;
procedure update_wherehourse (wareid in number,warename in varchar ,local_id in number) IS 
begin
update WAREHOUSES set WAREHOUSE_ID = wareid , WAREHOUSE_NAME = warename
where LOCATION_ID = local_id ;
if sql%notfound then 
dbms_output.put_line('no such location with this id to update');
elsif sql%found then 
dbms_output.put_line('location updated secuessfully');
end if ;
end ;
begin
a:= &a ;
b:= '&b' ;
c:= &c ;
update_wherehourse(a,b,c) ;
end ;

—question 3

set serveroutput on ;
declare 
c number ;
procedure update_wherehourse (local_id in number) IS 
begin
delete from WAREHOUSES where LOCATION_ID = local_id ;
if sql%notfound then 
dbms_output.put_line('no such warehouse with this id to delete');
elsif sql%found then 
dbms_output.put_line('Warehouse deleted secuessfully');
end if ;
end ;
begin
c:= &c ;
update_wherehourse(c) ;
end ;

—question 4

set serveroutput on ;
declare 
myhouse WAREHOUSES%ROWTYPE ;
c number ;
procedure update_wherehourse (local_id in number) IS 
begin
select * INTO myhouse from WAREHOUSES where LOCATION_ID = local_id ;
if sql%notfound then 
dbms_output.put_line('no such location with this id ');
elsif sql%found then 
dbms_output.put_line('location founded : ' || myhouse.WAREHOUSE_ID 
|| ' | ' ||  myhouse.WAREHOUSE_NAME || ' | ' || myhouse.LOCATION_ID);
end if ;
end ;
begin
c:= &c ;
update_wherehourse(c) ;
end ;

—question5

set serveroutput on ;
declare 
quant ORDER_ITEMS.QUANTITY%TYPE ;
price ORDER_ITEMS.UNIT_PRICE%TYPE ;
a number ;
b number ;
c number ;
d number ;
chiffre_affaire number ;
procedure calcule_ca (idd in number , CA out number) IS 
begin
select sum(QUANTITY*UNIT_PRICE) into chiffre_affaire from ORDERS join ORDER_ITEMS 
on ORDERS.ORDER_ID = ORDER_ITEMS.ORDER_ID  where SALESMAN_ID = &idd;
if sql%notfound then 
dbms_output.put_line('no such seller with this id ');
elsif sql%found then 
dbms_output.put_line('seller found  ');
CA := chiffre_affaire;
end if ;
end ;
begin
calcule_ca(c,d) ;
dbms_output.put_line('voice son chiffre dafaire ' || d);
end ;

— functions 
—question 1
set serveroutput on ;
declare 
a number ;
b number ;
function sum_price(idd in number) 
return number
is price_total number ;
begin
select sum(QUANTITY*UNIT_PRICE) into price_total from ORDERS 
join ORDER_ITEMS on ORDERS.ORDER_ID = ORDER_ITEMS.ORDER_ID  
where CUSTOMER_ID = &idd and STATUS = 'Shipped';
return price_total;
end ;
begin
b := sum_price(a);
dbms_output.put_line('voici le prix total de la commande ' || b);
end ;

—question 2

set serveroutput on ;
declare 
a number ;
b number ;
function sum_cmd return number is
total number;
begin
select count(*) into total from ORDERS  
where STATUS = 'Pending';
return total;
end ;
begin
b := sum_cmd;
dbms_output.put_line('voici le nombre total de commande pending ' || b);
end ;

————— déclencheurs ————————
—- question 1 
create or replace trigger affiche_cmd 
after insert on ORDER_ITEMS
for each row
declare  
resume_cmd ORDER_ITEMS%ROWTYPE ;
begin
select * into resume_cmd from ORDER_ITEMS ;
end ;

— question 2

set serveroutput on ;
create or replace trigger alerte 
after update or insert or delete  on INVENTORIES
for each row
declare  
qty INVENTORIES%ROWTYPE ;
begin
select *  into qty from INVENTORIES where QUANTITY < 10 ;
if sql%found then 
dbms_output.put_line('Alerte il ya une rupture dans le stock') ;
elsif sql%found  
then
dbms_output.put_line('Operation effectuer avec succées') ;
end if;
end ;

—- question 3

set serveroutput on ;
create or replace trigger autorisation 
before update on CUSTOMERS
for each row
declare 
mycredit CUSTOMERS.CREDIT_LIMIT%type ;
begin
if mycredit between 28 and 30 then 
dbms_output.put_line('requete nest pas autoriée !') ;
else 
dbms_output.put_line('requete autoriée ') ;
end if ;
end ;

—- question 4

set serveroutput on ;
create or replace trigger interdiction 
before insert or delete or update on EMPLOYEES
for each row
declare 
hire date;
date_emp EMPLOYEES.HIRE_DATE%type ;
begin
SELECT sysdate into hire from dual ;
if date_emp > hire then
dbms_output.put_line('requete non autoriée ') ;
end if ;
end ;

—-question 5

set serveroutput on ;
create or replace trigger remise 
before insert on ORDER_ITEMS
for each row
declare 
remi number ;
price ORDER_ITEMS.UNIT_PRICE%type ;
begin
if price > 10000 then
update ORDER_ITEMS set UNIT_PRICE =  (UNIT_PRICE*95)/100 ;
dbms_output.put_line('LES COMMANDES SONT MISES À JOURS ') ;
end if ;
end ;
