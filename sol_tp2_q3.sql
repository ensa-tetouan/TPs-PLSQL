SET SERVEROUTPUT ON;    
-- CHABOU SOUFIAN GI2 --




-- QUESTION 3 --


DECLARE 

     NOMBRE_LIGNE NUMBER(10) :=0;
     
         v_client_id customers.customer_id%type;
        CURSOR C_ORDER IS
        SELECT * FROM ORDERS WHERE customer_id= v_client_id ;
        
        CURSOR C_CUSTOMERS IS
        SELECT * FROM CUSTOMERS;
        
        i INTEGER := 0;
     
        TOTAL_ACHAT order_items.unit_price%TYPE :=0;
        PRIX order_items.unit_price%TYPE :=0;
          
BEGIN

     DBMS_OUTPUT.PUT_LINE('**************************************************************** ');
  
     FOR M IN C_CUSTOMERS LOOP
        v_client_id := M.CUSTOMER_ID;
      FOR N IN C_ORDER LOOP
        i := i+1;
        SELECT unit_price INTO PRIX FROM order_items  WHERE order_items.order_id = N.ORDER_ID AND ROWNUM =1;
        TOTAL_ACHAT := TOTAL_ACHAT + PRIX ;
      END LOOP;
      IF I > 0 THEN
       DBMS_OUTPUT.PUT_LINE('le nombrede commande de cliant '|| v_client_id||' est : '||i || ' le total d''achat est : ' || TOTAL_ACHAT||'$');
       IF TOTAL_ACHAT >= 2000 THEN
        UPDATE CUSTOMERS 
        SET CUSTOMERS.CREDIT_LIMIT = CREDIT_LIMIT + 50 WHERE customer_id = M.CUSTOMER_ID  ;
         NOMBRE_LIGNE := NOMBRE_LIGNE + 1;
     
       END IF;
       TOTAL_ACHAT := 0;
      END IF;
     i := 0;
     END LOOP;
              
       DBMS_OUTPUT.PUT_LINE(' ***************************** fin ***************************** ');
      dbms_output.put_line('le nombre de ligne ayant été mise à jour : '||NOMBRE_LIGNE);
    
         DBMS_OUTPUT.PUT_LINE('**************************************************************** ');

END;


