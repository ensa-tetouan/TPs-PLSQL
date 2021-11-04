SET SERVEROUTPUT ON 

            -------------------------------------------------------
            --                                                   --
            --   TP 3 : PROCEDURES / FONCTIONS / DECLENCHEURS    --
            --           OSSAMA ELMORABET / GI2                  --                             --
            --                                                   --   
            -------------------------------------------------------
            

--------------------------------------------------------- Partie Procedures -------------------------------------------------------------------
---Question 1 : Une procédure qui Ajoute   un warehouse  à une location donnée ---
DECLARE
    -- record pour stocker les information de location à donné
    r_location locations%Rowtype;
    
    PROCEDURE Add_Warehouses(p_location IN locations%Rowtype ,
                             p_warehouse_name IN warehouses.warehouse_name%TYPE ,
                             p_location_id IN warehouses.location_id%TYPE
                             )IS
    
    BEGIN
    -- 1 erment on insère la location donné
     INSERT INTO locations VALUES r_location;
     -- après on ajout warehouse qu'aure le meme id de location donné pour location_id
     INSERT INTO warehouses(warehouse_name ,location_id) VALUES (p_warehouse_name , p_location_id);
    END;
BEGIN
    r_location.location_id := 46;
    r_location.address := 'Av far 3';
    r_location.postal_code := 93200;
    r_location.city := 'tanger';
    r_location.state := 'Tanger';
    r_location.country_id := 'MR';
    Add_Warehouses(r_location ,'my warehouse' , r_location.location_id);
END;

---Question 2 : Une procédure qui met à jour les donnees   d'un warehouse   ---

DECLARE
    -- location id de warehouse a mettre à jour
    v_location_id locations.location_id%TYPE;
    -- on passe comme para id de warehouse a modifier avec le nouveau nom de warehouse et le nouveau location_id
    PROCEDURE Update_Warehouses( p_location_id IN warehouses.location_id%TYPE ,
                                 p_warehouse_name IN warehouses.warehouse_name%TYPE ,
                                 p_warehouse_id IN warehouses.warehouse_id%TYPE
                             )IS
    
    BEGIN
    -- modification de la ligne demande
     UPDATE warehouses
     SET warehouse_name = p_warehouse_name ,location_id = p_location_id
     WHERE warehouse_id = p_warehouse_id ;
    END;
BEGIN
    --32 C'est le id de warehouse a modifier 'Bombay' est le nouveau nom v_location_id est le nouveau location_id
    v_location_id := 45;
    Update_Warehouses(v_location_id ,'Bombay' , 32);
END;

---Question 3 : Une procédure qui supprime  un warehouse  ---

DECLARE 

--declaraton des variables

v_id WAREHOUSES.WAREHOUSE_ID%type;


--Debut de la procedure
 PROCEDURE delete_warehouse
 ( ware_id IN WAREHOUSES.WAREHOUSE_ID%type )

IS

BEGIN
DELETE
FROM
    WAREHOUSES
WHERE
    WAREHOUSES.WAREHOUSE_ID = ware_id ; 
    
END delete_warehouse ;
--Fin de la procedure 

BEGIN

--Partie Test 
v_id := '&v_id'  ; 

delete_warehouse(v_id) ; 
-- Fin Test 

END ;  



----- QUESTION 4  Une procédure qui affiche  les warehouses d'une location donnée  ---
DECLARE 

--declaraton des variables

v_id WAREHOUSES.WAREHOUSE_ID%type;



--Debut de la procedure
 PROCEDURE chercher_warehouses
 ( loca_id IN LOCATIONS.LOCATION_ID%type )

IS
CURSOR C_CUR IS SELECT  warehouses.warehouse_name from WAREHOUSES  where   warehouses.location_id = loca_id   ;
v_name warehouses.warehouse_name%type ; 
BEGIN

open C_CUR ;	
Loop
FETCH C_CUR INTO v_name ;
exit when C_CUR%notfound ;
dbms_output.put_line( v_name  ) ; 
end loop ;
close C_CUR ;


    
END chercher_warehouses ;
--Fin de la procedure 

BEGIN

--Partie Test 
v_id := '&v_id'  ; 

chercher_warehouses(v_id) ; 
-- Fin Test 

END ;


----- QUESTION 5  Une procédure qui calcule le CA d'un employé  ---

DECLARE
    -- L'id de l'employee a calculer CA
    v_employee_id employees.employee_id%TYPE;
    
    PROCEDURE Calcul_CA_emp( p_employee_id IN employees.employee_id%TYPE
                             )IS
    --variables locat 
    -- record pour stocker les resultats de cursor
    TYPE r_emp_infos IS RECORD 
    (
        emp_id employees.employee_id%TYPE,
        v_order_id orders.order_id%TYPE,
        CA_order order_items.unit_price%TYPE
     );
    r_emp r_emp_infos;
    -- on recupere les orders de chaque emp from tableau des orders et et on calcul la somme de qunt*price de cet order
    CURSOR c_ca_emp IS
        SELECT salesman_id , orders.order_id , SUM(QUANTITY*UNIT_PRICE) 
        FROM orders
        JOIN order_items 
        ON orders.order_id = order_items.order_id
        WHERE salesman_id = p_employee_id
        GROUP BY salesman_id ,orders.order_id;
    -- chifre d'affaires total de l'emp
    CA_total NUMBER(30,2) := 0;
    BEGIN
        OPEN c_ca_emp;
        LOOP   
            FETCH c_ca_emp INTO r_emp;
            EXIT WHEN c_ca_emp%notfound;
             DBMS_OUTPUT.PUT_LINE('CA order '|| r_emp.v_order_id ||' = ' || r_emp.CA_order);
            CA_total := CA_total + r_emp.CA_order;
            
        END LOOP;
        CLOSE c_ca_emp;
        DBMS_OUTPUT.PUT_LINE('CA total = ' || CA_total);
    END;
BEGIN   
    Calcul_CA_emp(54);
END;

--------------------------------------------------------- Partie Fonctions -------------------------------------------------------------------



--QUESTION 1 -- Fonction qui retourne le prix total d'une commande 
DECLARE 

--declaraton des variables

prix_tot number ; 
v_id CUSTOMERS.CUSTOMER_ID%type;

--Debut de la fonction

FUNCTION prix_total
 ( v_customer_id IN CUSTOMERS.CUSTOMER_ID%type )
return number 
IS

--DECLARATION DES VARIABLE DE LA FONCTION 
v_total   number  ;
v_order_id ORDERS.ORDER_ID%type ;
v_price ORDER_ITEMS.UNIT_PRICE%type ; 
CURSOR C_CUR2 IS SELECT ORDER_ID  from ORDERS where  CUSTOMER_ID = v_customer_id ;
CURSOR C_CUR3 IS SELECT QUANTITY*UNIT_PRICE from ORDER_ITEMS where   ORDER_ID = v_order_id ;


BEGIN
v_total :=0 ; 
open C_CUR2 ;
loop
FETCH C_CUR2 INTO v_order_id   ;
exit when C_CUR2%notfound ;

open C_CUR3 ;
 loop 
 FETCH C_CUR3 INTO v_price    ;
 exit when C_CUR3%notfound ;
 v_total := v_total + v_price ; 
end loop ; 
close C_CUR3 ;
end loop ; 
close C_CUR2 ;

return v_total ;   
END prix_total;
--Fin de la fonction

BEGIN

--Partie Test 
v_id := '&v_id'  ; 

prix_tot := prix_total(v_id) ; 

--Affichage du prix total 
dbms_output.put_line('Le prix total est  ' || prix_tot ) ; 
-- Fin Test 

END ;


--QUESTION 2 -- Fonction qui retourne le nombre de commande qui ont le status "PENDING" 

DECLARE
    nb_commandes number;
    FUNCTION f_commandes RETURN Number IS
    resultat number;
    BEGIN
        SELECT COUNT(order_id) INTO resultat FROM orders WHERE status = 'Pending';
        return resultat;
    END;
BEGIN
    nb_commandes := f_commandes();
    DBMS_OUTPUT.PUT_LINE('Le nombre des commandes ayant un status Pending est : ' || nb_commandes);
END;


--------------------------------------------------------- Partie Déclencheurs -------------------------------------------------------------------
--Question 1 --  un déclencheur qui affiche le résumé d’une commande

create or replace TRIGGER Q1
AFTER INSERT ON ORDERS 
FOR EACH ROW
begin

dbms_output.put_line('Order Informations : order id : ' || :NEW.ORDER_ID);
dbms_output.put_line('customer id : ' || :NEW.CUSTOMER_ID);
dbms_output.put_line('status : ' || :NEW.STATUS);
dbms_output.put_line('salseman id : ' || :NEW.SALESMAN_ID);
dbms_output.put_line('order date : ' || :NEW.ORDER_DATE);
end ;

--Question 2 --  un déclencheur qui  affiche une alerte du stocke une fois le nombre d’article disponible en inventaire est < 10

create or replace TRIGGER Q2
AFTER UPDATE ON INVENTORIES 
FOR EACH ROW
WHEN (NEW.QUANTITY < 10)
begin
dbms_output.put_line('Alerte de stocke');
end ;

--Question 3 -- un déclencheur qui n’autorise pas la modification du CREDIT_LIMIT des clients entre le 28 et 30 de chaque mois

create or replace TRIGGER Q3
BEFORE UPDATE ON CUSTOMERS
FOR EACH ROW
DECLARE
    jr number := EXTRACT(DAY FROM SYSDATE);
begin
     if(jr >= 28 and jr <= 30) THEN 
     dbms_output.put_line('Modification Interdit :( ' || jr);
     :NEW.CREDIT_LIMIT := :OLD.CREDIT_LIMIT;
     END IF;
end ;

--Question 4 -- un déclencheur qui  interdit l’ajout d’un employé si HIRE_DATE est > a Date d’aujourd’hui

create or replace TRIGGER Q4
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
DECLARE
PROCEDURE interdit IS
BEGIN
raise_application_error(-20710,'Ajout Interdit');
END;
begin
     if(:NEW.HIRE_DATE > SYSDATE) THEN 
     interdit();
     END IF;
end ;

--Question 5 -- un déclencheur qui applique une remise de 5% si le prix total de la commande est > 10000$

------CASE  1

CREATE OR REPLACE TRIGGER Q51
BEFORE  update OR INSERT  ON ORDER_ITEMS
FOR EACH ROW 
DECLARE

prix_tot number ; 
BEGIN
select sum( UNIT_PRICE*QUANTITY ) into prix_tot from ORDER_ITEMS where ORDER_ID = :new.ORDER_ID ; 
if ( prix_tot > 10000 )then
 :new.UNIT_PRICE := :old.UNIT_PRICE - 0.05*(:old.UNIT_PRICE ) ;
END IF ; 
END ;

--------------------------------
------CASE  2
CREATE OR REPLACE TRIGGER Q5 
After INSERT OR UPDATE ON ORDERS
DECLARE
prix_tot number ;
FUNCTION prix_total
 ( v_customer_id IN CUSTOMERS.CUSTOMER_ID%type )
return number 
IS

--DECLARATION DES VARIABLE DE LA FONCTION 
v_total   number  ;
v_order_id ORDERS.ORDER_ID%type ;
v_price ORDER_ITEMS.UNIT_PRICE%type ; 
CURSOR C_CUR2 IS SELECT ORDER_ID  from ORDERS where  CUSTOMER_ID = v_customer_id ;
CURSOR C_CUR3 IS SELECT QUANTITY*UNIT_PRICE from ORDER_ITEMS where   ORDER_ID = v_order_id ;


BEGIN
v_total :=0 ; 
open C_CUR2 ;
loop
FETCH C_CUR2 INTO v_order_id   ;
exit when C_CUR2%notfound ;

open C_CUR3 ;
 loop 
 FETCH C_CUR3 INTO v_price    ;
 exit when C_CUR3%notfound ;
 v_total := v_total + v_price ; 
end loop ; 
close C_CUR3 ;
end loop ; 
close C_CUR2 ;

return v_total ;   
END prix_total;


BEGIN

prix_tot := prix_total(:new.CUSTOMER_ID );
if ( prix_tot > 10000) then
prix_tot := prix_tot - 0.05*prix_tot ; 
      dbms_output.put_line('Le prix total est  : '  || prix_tot);

else
      dbms_output.put_line('Le prix total est  : '  || prix_tot);
END IF ; 

END ;




