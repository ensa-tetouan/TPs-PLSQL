-- MERROUN Moad Génie Informatique 2
-- TP 3  : Procédures, Fonctions et Déclencheurs
-- Procédures
-- Question 1
SET SERVEROUTPUT ON;
DECLARE
v_warehouse_name warehouses.warehouse_name%TYPE; 
v_location_id warehouses.location_id%TYPE;
PROCEDURE 
ajouterWarehouse(warehouse_name IN warehouses.warehouse_name%TYPE, location_id IN warehouses.location_id%TYPE) IS
BEGIN
INSERT INTO warehouses(warehouse_name, location_id) VALUES 
(warehouse_name, location_id);
END ajouterWarehouse; 
BEGIN
-- Call the procedure
v_warehouse_name := '&warehouse_name'; 
v_location_id := '&location_id';
ajouterWarehouse(v_warehouse_name, v_location_id);
DBMS_OUTPUT.PUT_LINE('warehouse inséré');
END;

-- Question 2
SET SERVEROUTPUT ON;
DECLARE
v_location_id warehouses.location_id%TYPE;
v_warehouse_name warehouses.warehouse_name%TYPE;
v_warehouse_id warehouses.warehouse_id%TYPE;
PROCEDURE 
updateWarehouse(loc_id IN warehouses.location_id%TYPE, wareho_name IN warehouses.warehouse_name%TYPE, wareho_id IN warehouses.warehouse_id%TYPE) IS
BEGIN
UPDATE warehouses SET warehouse_name=wareho_name WHERE location_id=loc_id AND warehouse_id=wareho_id;
END updateWarehouse; 
BEGIN
-- Call the procedure
v_location_id := '&location_id';
v_warehouse_name := '&warehouse_name';
v_warehouse_id := '&warehouse_id';
updateWarehouse(v_location_id,v_warehouse_name,v_warehouse_id );
DBMS_OUTPUT.PUT_LINE('warehouse mis a jour');
END;

-- Question 3
SET SERVEROUTPUT ON;
DECLARE
v_warehouse_id warehouses.warehouse_id%TYPE;
PROCEDURE 
supprimerWarehouse(p_warehouse_id IN warehouses.warehouse_id%TYPE) IS
BEGIN
DELETE FROM WAREHOUSES WHERE warehouse_id=p_warehouse_id;
END supprimerWarehouse; 
BEGIN
-- Call the procedure
v_warehouse_id := '&warehouse_id';
supprimerWarehouse(v_warehouse_id);
DBMS_OUTPUT.PUT_LINE('warehouse supprimé');
END;

-- Question 4
SET SERVEROUTPUT ON;
DECLARE
v_location_id warehouses.location_id%TYPE;
r_warehouses warehouses%ROWTYPE;
PROCEDURE 
afficherWarehouses(loc_id IN warehouses.location_id%TYPE) IS
    CURSOR c_warehouses IS
    SELECT * FROM warehouses WHERE location_id=loc_id;
    BEGIN
    OPEN c_warehouses;
	DBMS_OUTPUT.PUT_LINE('location_id : '||loc_id||', ses warehouses sont : ');
    LOOP
    FETCH c_warehouses INTO r_warehouses.WAREHOUSE_ID ,r_warehouses.WAREHOUSE_NAME ,r_warehouses.LOCATION_ID;
	EXIT WHEN c_warehouses %notfound;
	DBMS_OUTPUT.PUT_LINE('warehouse_id : '||r_warehouses.warehouse_id||', warehouse_name : '||r_warehouses.warehouse_name);
    END LOOP;
END afficherWarehouses; 
BEGIN
-- Call the procedure
v_location_id := '&location_id';
afficherWarehouses(v_location_id);
END;

-- Question 5
SET SERVEROUTPUT ON;
DECLARE
v_salesman_id orders.salesman_id%TYPE;
v_total int;
PROCEDURE chiffreAffaire
(salesma_id IN orders.salesman_id%TYPE, total OUT int) IS
BEGIN
SELECT SUM(order_items.quantity*order_items.unit_price)
INTO total
FROM orders inner join order_items on orders.order_id=order_items.order_id
WHERE orders.salesman_id=salesma_id;
END chiffreAffaire;
BEGIN
v_salesman_id := '&salesman_id';
chiffreAffaire(v_salesman_id, v_total);
DBMS_OUTPUT.PUT_LINE('L employé qui porte l id : '||v_salesman_id||' a le chiffre d affaire : '||v_total);
END;

--Fonctions
-- Question 1
SET SERVEROUTPUT ON;
DECLARE
v_customer_id customers.customer_id%TYPE;
v_total int;
FUNCTION prixCommande
(custom_id IN customers.customer_id%TYPE) RETURN NUMBER IS
total number;
BEGIN
SELECT SUM(order_items.quantity*order_items.unit_price)
INTO total
FROM orders inner join order_items on orders.order_id=order_items.order_id
WHERE orders.customer_id=custom_id;
RETURN total;
END prixCommande;
BEGIN
v_customer_id := '&customer_id';
v_total := prixCommande(v_customer_id);
DBMS_OUTPUT.PUT_LINE('Le prix total des commandes du client  qui porte l id : '||v_customer_id||' est : '||v_total);
END;

-- Question 2
SET SERVEROUTPUT ON;
DECLARE
v_total int;
FUNCTION pendingCommande RETURN NUMBER IS
total number;
BEGIN
SELECT COUNT(*)
INTO total
FROM orders WHERE orders.status='Pending';
RETURN total;
END pendingCommande;
BEGIN
v_total := pendingCommande;
DBMS_OUTPUT.PUT_LINE('Le nombre de commande qui ont le statut Pending est : '||v_total);
END;

--Déclencheurs
-- Question 1
create or replace NONEDITIONABLE TRIGGER INSERT_ORDERS
AFTER INSERT ON ORDERS
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('Le client portant ID : '||
:NEW.CUSTOMER_ID||' a passé la commande : '||:NEW.ORDER_ID
||' dont le status est : '||:NEW.status
||' à la date : '||:NEW.order_date
||' et le salesman concerné est celui qui porte l id  : '||:NEW.SALESMAN_ID);
END;

-- Question 2
create or replace NONEDITIONABLE TRIGGER UPDATE_INVENTORIES
AFTER UPDATE ON INVENTORIES
FOR EACH ROW
WHEN (OLD.QUANTITY < 10)
BEGIN
DBMS_OUTPUT.PUT_LINE('Alerte du stocke, juste '||:OLD.QUANTITY
||' articles sont disponibles du produit qui a l ID : '||:OLD.PRODUCT_ID
||' dans le warehouse qui a l ID : '||:OLD.warehouse_id);
END;

-- Question 3
create or replace NONEDITIONABLE TRIGGER UPDATE_CREDIT_LIMIT
BEFORE UPDATE OF CREDIT_LIMIT ON CUSTOMERS
FOR EACH ROW
WHEN (TO_CHAR(SYSDATE, 'DD') <= 30 AND TO_CHAR(SYSDATE, 'DD') >=28)
DECLARE
   credit_limit_excep EXCEPTION;
   PRAGMA EXCEPTION_INIT( credit_limit_excep, -20001 );
BEGIN
RAISE_APPLICATION_ERROR(-20001, 'Vous ne pouvez pas modifier le CREDIT_LIMIT des client entre le 28 et 30 de chaque mois');
END;

-- Question 4
create or replace NONEDITIONABLE TRIGGER INSERT_EMPLOYEE
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
WHEN (NEW.HIRE_DATE > TO_CHAR(SYSDATE, 'DD/MM/YY'))
DECLARE
   hire_date_excep EXCEPTION;
   PRAGMA EXCEPTION_INIT( hire_date_excep, -20002 );
BEGIN
RAISE_APPLICATION_ERROR(-20002, 'Vous ne pouvez pas ajouter un employee si hire_date est > a la date d aujourdhui');
END;

-- Question 5
create or replace TRIGGER remise
BEFORE INSERT OR UPDATE ON ORDER_ITEMS
FOR EACH ROW
WHEN (NEW.quantity*NEW.unit_price > 10000)
BEGIN
dbms_output.put_line('L ancien prix totale de la commande avant la remise est  : '||:NEW.unit_price*:NEW.quantity);
:NEW.unit_price := :NEW.unit_price  - :NEW.unit_price*0.05;
dbms_output.put_line(' Le nouveau prix totale de la commande apres la remise est  : '||:NEW.unit_price*:NEW.quantity);
END;