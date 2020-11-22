SET SERVEROUTPUT ON; --CHABOU SOUFIAN GI2

DECLARE 
    ID CUSTOMERS.CUSTOMER_ID%TYPE :=1;
    
    CURSOR C_COMMANDE IS
    SELECT * FROM CUSTOMERS INNER JOIN ORDERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID AND ORDERS.CUSTOMER_ID = ID;



BEGIN
    ID:= &ID;
    DBMS_OUTPUT.PUT_LINE('LE CUSTOMER : '|| ID);
    for N IN C_COMMANDE loop
    
    DBMS_OUTPUT.PUT_LINE('LA COMMANDE : '||N.ORDER_ID );
    
    END LOOP;
END;
/



DECLARE

 ID_SAL employees.employee_id%TYPE :=60;
    cursor c_vente is
    SELECT * FROM EMPLOYEES INNER JOIN ORDERS ON employees.employee_id = ORDERS.salesman_id and orders.status = 'Shipped' AND ORDERS.salesman_id = id_sal; 
    
BEGIN
     ID_SAL:=&ID_SAL;
     
  for N IN c_vente loop
    
    DBMS_OUTPUT.PUT_LINE('LA COMMANDE : '||N.ORDER_ID  );
    
    END LOOP;
END;



