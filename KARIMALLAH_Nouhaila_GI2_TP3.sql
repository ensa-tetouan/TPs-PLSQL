------------------------------------------  Nom et Prénom :: KARIMALLAH Nouhaila     GI2  -------------------------------------------
-------------------------------------------  TP3 : Procédures, Fonctions et Déclencheurs   ------------------------------------------

------------------------------- Procédures:: 

------------------------------------------------------------------ Question 1:--------------------------------------------------------
SET SERVEROUTPUT ON
ACCEPT ID_Location PROMPT 'Donner ID de la location';

DECLARE 

  ID_Location locations.location_id%TYPE;
  V_warehouse warehouses.warehouse_name%TYPE;
  V_city locations.city%TYPE;
  V_state locations.STATE%TYPE;
  
PROCEDURE ProcWarehouse( x IN locations.location_id%TYPE, y OUT warehouses.warehouse_name%TYPE) IS
BEGIN
SELECT CITY, STATE INTO V_city, V_state FROM LOCATIONS where location_id = x; 
y := V_state ||' '|| V_city ;
INSERT INTO WAREHOUSES(WAREHOUSE_NAME, LOCATION_ID) VALUES( y, x ) ;
END;

BEGIN
 ID_Location := '&ID_Location';
 ProcWarehouse(ID_Location, V_warehouse);
END;

------------------------------------------------------------------ Question 2:--------------------------------------------------------

SET SERVEROUTPUT ON
ACCEPT ID_ware PROMPT 'Insert Warehouse ID';
ACCEPT V_city PROMPT 'Insert the name of the state';
ACCEPT V_state PROMPT 'Insert the name of the city';
DECLARE 
  ID_ware warehouses.warehouse_id%TYPE;
  V_warehouse warehouses.warehouse_name%TYPE;
  V_city locations.city%TYPE;
  V_state locations.STATE%TYPE;
  
PROCEDURE UpdateWarehouse( x IN warehouses.warehouse_id%TYPE,y IN locations.city%TYPE, z IN locations.STATE%TYPE) IS
BEGIN
UPDATE warehouses SET warehouse_name = z ||', '|| y where warehouse_id = x; 
END;

BEGIN
 ID_ware := '&ID_ware';
 V_city := '&V_city';
 V_state := '&V_state';
 UpdateWarehouse(ID_ware, V_city, V_state);
END;

------------------------------------------------------------------ Question 3:--------------------------------------------------------
ACCEPT V_ware PROMPT 'Insert Warehouse ID';
DECLARE

    V_ware WAREHOUSES.WAREHOUSE_ID%type;
    
PROCEDURE SupprWare(ID_ware IN WAREHOUSES.WAREHOUSE_ID%TYPE) IS
BEGIN
   DELETE FROM WAREHOUSES WHERE warehouse_id = ID_ware;
END;

BEGIN
  V_ware := '&V_ware';
  SupprWare(V_ware);
END;

------------------------------------------------------------------ Question 4:---------------------------------------------------------
SET SERVEROUTPUT ON
ACCEPT V_loc PROMPT 'Précisez l ID d une location';

DECLARE 
  V_wareName warehouses.warehouse_name%TYPE;
  V_loc LOCATIONS.location_id%TYPE;
  i INTEGER;
  CURSOR ware_name(var_id LOCATIONS.location_id%TYPE) is
   SELECT warehouse_name from warehouses where location_id = var_id;
  
PROCEDURE LOC_Warehouse( x IN LOCATIONS.LOCATION_ID%TYPE, y OUT warehouses.warehouse_name%TYPE) IS
BEGIN   
  OPEN ware_name(x);
  LOOP
  Fetch ware_name into y;
  Exit when ware_name%notfound;
  dbms_output.put_line('Location ' || i ||' : '|| y);
  i := i+1;
  END LOOP; 
  close ware_name;
END;

BEGIN
 V_loc := '&V_loc';
 i:= 1;
 LOC_Warehouse(V_loc, V_wareName);
END;

------------------------------------------------------------------ Question 5:---------------------------------------------------------
SET SERVEROUTPUT ON;
ACCEPT V_employe PROMPT 'Précisez l ID d un employé';
DECLARE

   v_order orders.order_id%TYPE;
   v_item  order_items.order_id%TYPE;
   V_employe employees.employee_id%type;
   a NUMBER;
   Ca number;
   cursor c_item(x order_items.order_id%TYPE ) is 
     select item_id FROM order_items where order_id = x;
   cursor c_order(y orders.order_id%TYPE ) is 
     select order_id FROM orders where salesman_id = y;

   PROCEDURE CA_proc(z IN orders.order_id%TYPE ) is
    begin
    Ca:= 0;
    open c_order(z);
    loop
        fetch c_order into v_order ;
        exit when c_order%notfound ;
        open c_item(v_order);
         loop
            fetch c_item into v_item ;
            exit when c_item%notfound ;
             select quantity*unit_price INTO a from order_items where (item_id = v_item and order_id = v_order );
             Ca:= Ca + a;
         end loop;
        close c_item ;
    end loop;
    close c_order ;
    dbms_output.put_line('le CA de l employé '|| z ||' vaut : '|| ca);
  end;
  
BEGIN
     V_employe := '&V_employe';
     CA_proc(V_employe);
END;

------------------------------- Fonctions :: 

------------------------------------------------------------------ Question 1:---------------------------------------------------------

SET SERVEROUTPUT ON
ACCEPT V_order PROMPT 'Insert Order ID';

DECLARE 
  V_order Orders.order_id%TYPE;
  y number;
  Pr number;
  
  CURSOR PrTotal(var_id Orders.order_id%TYPE) is
   SELECT Quantity*UNIT_PRICE from ORDER_ITEMS where order_id = var_id;
  
  Function Commande( x IN Orders.order_id%TYPE)
  RETURN NUMBER IS
    i number:=0;
  BEGIN   
   OPEN PrTotal(x);
   LOOP
    Fetch PrTotal into y;
    Exit when PrTotal%notfound;
     i := i + y;
   END LOOP; 
  close PrTotal;
  return i ;
  END;

BEGIN

 V_order := '&V_order';
 Pr := Commande(V_order);
 dbms_output.put_line('le prix total de la commande '|| V_order ||' is ' || Pr);
 
END;

------------------------------------------------------------------ Question 2:---------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE 
  Pr number;
  
Function pendingCommande
RETURN NUMBER IS
 i number;
BEGIN
   SELECT COUNT(*) INTO i FROM ORDERS WHERE STATUS = 'Pending';
  return i ;
END;

BEGIN
 Pr := pendingCommande;
 dbms_output.put_line('le nombre de commande qui ont le statut pending est :'|| Pr);
END;

------------------------------- Déclencheurs :: 
------------------------------------------------------------------ Question 1:---------------------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER DECLENCHEUR1
 After INSERT OR UPDATE OR DELETE ON orders
 for EACH ROW
  DECLARE

  BEGIN
   IF inserting OR updating then
    dbms_output.put_line('le id de la commande: '|| :new.order_id || 'le client id: '|| :new.customer_id || 'le status de la commande: '|| :new.status || 'le salesman id: '|| :new.salesman_id || 'la date de la commande: '|| :new.order_date);
   elsif deleting then
    dbms_output.put_line('le id de la commande supprimée: '|| :new.order_id || 'le id du client supprimé: '|| :new.customer_id || 'le status de la commande supprimé : '|| :new.status || 'le salesman id supprimé: '|| :new.salesman_id || 'la date de la commande supprimée: '|| :new.order_date);
   end if;
  END;

------------------------------------------------------------------ Question 2:---------------------------------------------------------

SET SERVEROUTPUT ON;
 CREATE OR REPLACE TRIGGER DECLENCHEUR2
 AFTER INSERT OR UPDATE OF QUANTITY ON INVENTORIES
 for each ROW
  WHEN (NEW.QUANTITY<10)
 BEGIN
  DBMS_OUTPUT.PUT_LINE('Le stock est inferieur a 10');
 END;

------------------------------------------------------------------ Question 3:---------------------------------------------------------

SET SERVEROUTPUT ON;
 CREATE OR REPLACE TRIGGER DECLENCHEUR3
  before UPDATE OF CREDIT_LIMIT ON customers
  for EACH ROW
 DECLARE
   v_date DATE;
   day integer;
   no_day EXCEPTION;
   credit customers.credit_limit%TYPE;
 BEGIN
   select sysdate into v_date from dual;
   SELECT EXTRACT(day FROM v_date) into day from dual;
    IF(day BETWEEN 28 AND 30) THEN
    RAISE no_day;
    END IF;
   EXCEPTION 
   WHEN no_day THEN
    dbms_output.put_line('nos autoriseés :( ');
    credit:= :OLD.credit_limit;
   UPDATE CUSTOMERS SET credit_limit = :OLD.credit_limit;
END;
------------------------------------------------------------------ Question 4:---------------------------------------------------------

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER DECLENCHEUR4
before INSERT ON employees
for EACH ROW
DECLARE
v_date DATE;
no_day EXCEPTION;
BEGIN
select sysdate into v_date from dual;
IF(v_date<:NEW.hire_date) THEN
RAISE no_day;
END IF;
EXCEPTION
WHEN no_day THEN
dbms_output.put_line('nos autoriseés :(');
delete from employees WHERE employee_id = :NEW.employee_id;
END;

------------------------------------------------------------------ Question 5:---------------------------------------------------------
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER DECLENCHEUR5
before INSERT or update OF order_id
ON order_items
for EACH row
declare
    CURSOR C_CUR1 IS SELECT QUANTITY*UNIT_PRICE from ORDER_ITEMS where   ORDER_ID =:new.order_id ;
    v_t NUMBER ;
    v_1 NUMBER ;
begin
    open C_CUR1 ;
    loop 
    FETCH C_CUR1 INTO v_1    ;
    exit when C_CUR1%notfound ;
    v_t := v_t + v_1 ; 
    end loop ; 
    close C_CUR1;
    if v_t>10000 then
    dbms_output.put_line('prix del commande apres repise est'|| v_t*5/100);
    end if;
end;