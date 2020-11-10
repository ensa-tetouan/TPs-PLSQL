SET SERVEROUTPUT ON;    
-- CHABOU SOUFIAN GI2 --



-- QUESTION 2 1er courseur --

DECLARE
      v_client_id customers.customer_id%type;
        CURSOR C_ORDER IS
        SELECT * FROM ORDERS WHERE customer_id= v_client_id ;
        
        CURSOR C_CUSTOMERS IS
        SELECT * FROM CUSTOMERS;
        
        i INTEGER := 0;
      
BEGIN
       DBMS_OUTPUT.PUT_LINE('**************************************************************** ');

   FOR M IN C_CUSTOMERS LOOP
        v_client_id := M.CUSTOMER_ID;
    FOR N IN C_ORDER LOOP
        i := i+1;
    END LOOP;
     DBMS_OUTPUT.PUT_LINE('le nombrede commande de cliant '|| v_client_id||' est : '||i);
     i := 0;
     END LOOP;
     
       DBMS_OUTPUT.PUT_LINE(' ***************************** fin ***************************** ');
     
END;
/
