/*                                                                          PARTIE1                                                             */
/*1. Ecrire une Procédure qui ajoute un WAREHOUSE pour une location donnée.
CREATE OR REPLACE PROCEDURE AJOUT_WAREHOUSE (v_location_id IN LOCATIONS.LOCATION_ID%TYPE)
IS 
    V_WAREHOUSE_NAME LOCATIONS.CITY%TYPE;
    compt number:=0;
    compt1 number:=0;
BEGIN
    SELECT count(location_id) into compt FROM  LOCATIONS WHERE  location_id=v_location_id;
    SELECT count(location_id) into compt1 FROM  WAREHOUSES WHERE  location_id=v_location_id;
    IF compt=1 AND compt1=0 THEN         
            SELECT CITY INTO V_WAREHOUSE_NAME FROM LOCATIONS WHERE LOCATION_ID=v_location_id;
            INSERT INTO WAREHOUSES(WAREHOUSE_NAME,LOCATION_ID)  VALUES(V_WAREHOUSE_NAME,v_location_id);
       ELSE 
                    dbms_output.put_line('Location id non valide ');
       END IF;
END AJOUT_WAREHOUSE;
EXECUTE AJOUT_WAREHOUSE(300); */

/* 2. Ecrire une procédure qui met à jour les données relatives à une WAREHOUSE d’une location donnée. 
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE MODIF_WAREHOUSE (v_location_id IN LOCATIONS.LOCATION_ID%TYPE,V_WAREHOUSE_NAME LOCATIONS.CITY%TYPE)
IS 
    compt number:=0;
BEGIN
    SELECT count(location_id) into compt FROM  WAREHOUSES WHERE  location_id=v_location_id;
    IF compt=1 THEN
        Update warehouses set WAREHOUSE_NAME=V_WAREHOUSE_NAME WHERE location_id=v_location_id;
        dbms_output.put_line('Modification avec succes');
    ELSE
        dbms_output.put_line('Location id non valide ');
    END IF;
END MODIF_WAREHOUSE;
EXECUTE MODIF_WAREHOUSE(200,'tokyo');*/
/*3. Ecrire une procédure qui permet de supprimer un WAREHOUSE données
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE SUPP_WAREHOUSE (V_WAREHOUSE_ID WAREHOUSES.WAREHOUSE_ID%TYPE)
IS 
    compt number:=0;
BEGIN
    SELECT count(WAREHOUSE_ID) into compt FROM  WAREHOUSES WHERE  WAREHOUSE_ID=V_WAREHOUSE_ID;
    IF compt=1 THEN
        DELETE FROM warehouses WHERE WAREHOUSE_ID=V_WAREHOUSE_ID;
        dbms_output.put_line('Suppression avec succes');
    ELSE
        dbms_output.put_line('warehouse id non valide ');
    END IF;
END SUPP_WAREHOUSE;
EXECUTE SUPP_WAREHOUSE(15);*/
/*4. Ecrire une procédure qui, pour une LOCATION donnée, affiche ses WAREHOUSES
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE AFFICH_WAREHOUSE (V_WAREHOUSE_ID IN WAREHOUSES.WAREHOUSE_ID %TYPE)
IS  
compt number:=0;
AFFICHAGE_WAREHOUSE WAREHOUSES%ROWTYPE;
BEGIN
    SELECT count(WAREHOUSE_ID) into compt FROM  WAREHOUSES WHERE  WAREHOUSE_ID=V_WAREHOUSE_ID;
    IF compt=1 THEN
        SELECT* INTO AFFICHAGE_WAREHOUSE FROM WAREHOUSES WHERE WAREHOUSE_ID=V_WAREHOUSE_ID;
        dbms_output.put('WAREHOUSE_ID = '||AFFICHAGE_WAREHOUSE.WAREHOUSE_ID||'; WAREHOUSE_NAME : '||AFFICHAGE_WAREHOUSE.WAREHOUSE_NAME);
        dbms_output.put_line('; LOCATION_ID = '||AFFICHAGE_WAREHOUSE.LOCATION_ID);
    ELSE
        dbms_output.put_line('warehouse id non valide ');
    END IF;
END AFFICH_WAREHOUSE;
EXECUTE AFFICH_WAREHOUSE(1);*/
/* 5. Ecrire une procédure calcule le CA d’un employé 
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE CA_EMPLOYE(V_EMPLOYE_ID IN EMPLOYEES.EMPLOYEE_ID%TYPE)
IS
CA number(19,9):=0;
BEGIN
    FOR VAR_EMP IN (SELECT * FROM ORDERS WHERE SALESMAN_ID=V_EMPLOYE_ID) LOOP
        FOR VAR_ORD IN (SELECT * FROM order_items WHERE ORDER_ID=VAR_EMP.ORDER_ID ) LOOP
                    CA := CA+(var_ord.quantity*var_ord.unit_price);
        END LOOP;
    END LOOP;
        dbms_output.put_line('le chiffre d affaire de l employe '||V_EMPLOYE_ID||' est '||CA);
END CA_EMPLOYE;

EXECUTE CA_EMPLOYE(1);*/

/*                                                                          PARTIE 2                                                             */

/*1. Ecrire une fonction retournant le prix total d’une commande d’un client 
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION PRIX_FUNCT(V_CUSTOMER_ID IN ORDERS.CUSTOMER_ID%TYPE)
RETURN number IS
PRIX number(19,9):=0;
BEGIN
    FOR VAR_CUS IN (SELECT * FROM ORDERS WHERE CUSTOMER_ID=V_CUSTOMER_ID) LOOP
        FOR VAR_ORD IN (SELECT * FROM order_items WHERE ORDER_ID=VAR_CUS.ORDER_ID ) LOOP
                    PRIX := PRIX+(var_ord.quantity*var_ord.unit_price);
        END LOOP;
    END LOOP;
        dbms_output.put_line('le prix total d’une commande du client  '||V_CUSTOMER_ID||' est '||PRIX);
        return PRIX;
END;
SET SERVEROUTPUT ON;
BEGIN 
    dbms_output.put_line('le prix total d’une commande du client  '||PRIX_FUNCT(1));
END; */
/* 2. Ecrire une fonction retournant le nombre de commande qui ont le statut : Pending 
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION nbr_FUNCT
RETURN number IS
nbr number:=0;
BEGIN
     SELECT count(*) INTO nbr FROM ORDERS WHERE STATUS='Pending';
     return nbr;
END;
SET SERVEROUTPUT ON;
BEGIN 
    dbms_output.put_line('le nombre de commande qui ont le statut : Pending  '||nbr_FUNCT);
END;*/






