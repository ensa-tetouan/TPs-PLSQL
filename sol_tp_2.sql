SET SERVEROUTPUT ON;    
-- CHABOU SOUFIAN GI2 --

-- QUESTION 1 --

DECLARE

    CURSOR C_EMPLOYEE IS
    SELECT * FROM EMPLOYEES;
    v_last_name_manager employees.last_name%TYPE;
BEGIN


    FOR N IN C_EMPLOYEE LOOP
        
        IF N.MANAGER_ID IS NULL THEN
          DBMS_OUTPUT.PUT_LINE('Employé : '||N.FIRST_NAME||' '||N.LAST_NAME||' ('||N.EMPLOYEE_ID||') '||'travaille comme '||N.JOB_TITLE||' depuis '||N.HIRE_DATE);

        ELSE
         SELECT LAST_NAME INTO  v_last_name_manager FROM EMPLOYEES WHERE EMPLOYEE_ID = N.MANAGER_ID;
        DBMS_OUTPUT.PUT_LINE('Employé : '||N.FIRST_NAME||' '||N.LAST_NAME||' ('||N.EMPLOYEE_ID||') '||'travaille comme '||N.JOB_TITLE||' depuis '||N.HIRE_DATE||' sous la direction de : '||v_last_name_manager );
        END IF;
    END LOOP;

END;
/

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


-- QUESTION 2 2eme courseur --
DECLARE

        v_salesman orders.salesman_id%type;
        
        CURSOR C_ORDER IS
         SELECT * FROM orders WHERE salesman_id = v_salesman ;
        
        CURSOR C_EMPLOYEE IS
        SELECT * FROM EMPLOYEES  WHERE job_title = 'Sales Representative';
        
        J INTEGER := 0;
      
BEGIN
       DBMS_OUTPUT.PUT_LINE('**************************************************************** ');

    FOR M IN C_EMPLOYEE  LOOP
          v_salesman := M.employee_id;
          
        FOR N IN C_ORDER LOOP
        J := J+1;
        END LOOP; 
        DBMS_OUTPUT.PUT_LINE('le nombre de vente de l''employee '|| v_salesman || ' est : ' ||J);
        J :=0;
     
    END LOOP;
       DBMS_OUTPUT.PUT_LINE(' ***************************** fin ***************************** ');

END;



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


/


-- QUESTION 4 --  Même question pour les clients ayant fait plus de 10000$ d’achat

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
       IF TOTAL_ACHAT >= 10000 THEN
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
/

-- QUESTION  5 :Ecrire un curseur permettant d’afficher le taux de vente d’un employé entre deux dates. Les dates sont à saisir par l’utilisateur (ne pas utiliser les curseurs paramétrés)

DECLARE

        v_salesman orders.salesman_id%type;
        date_debut date;
        date_fin date;
        CURSOR C_ORDER2 IS
         SELECT * FROM orders WHERE salesman_id = v_salesman ;
         
        CURSOR C_ORDER IS
         SELECT * FROM orders WHERE salesman_id = v_salesman and order_date >= date_debut  and  order_date <= date_fin;
        
        CURSOR C_EMPLOYEE IS
        SELECT * FROM EMPLOYEES  WHERE job_title = 'Sales Representative';
        
        total_Vente order_items.unit_price%TYPE :=0;
        Vente order_items.unit_price%TYPE :=0;
        PRIX order_items.unit_price%TYPE :=0;



        J INTEGER := 0;
      
BEGIN
       DBMS_OUTPUT.PUT_LINE('**************************************************************** ');
 
       date_debut:='&date_debut';
       date_fin:='& date_fin';
       
    FOR M IN C_EMPLOYEE  LOOP
          v_salesman := M.employee_id;
          
        FOR N IN C_ORDER LOOP
        J := J+1;
         SELECT unit_price INTO PRIX FROM order_items  WHERE order_items.order_id = N.ORDER_ID AND ROWNUM =1;
         total_Vente := total_Vente + PRIX ;
        END LOOP; 
        IF J > 0 THEN
        DBMS_OUTPUT.PUT_LINE('le nombre de vente de l''employee '|| v_salesman || ' est : ' ||J);
        
        END IF;
        J :=0;
     
      END LOOP;
       DBMS_OUTPUT.PUT_LINE('le chiffre d''affaire total de cette periode : '||total_Vente||'$');
       
       
       
        v_salesman:='&v_salesman';

       
        FOR N IN C_ORDER LOOP
         SELECT unit_price INTO PRIX FROM order_items  WHERE order_items.order_id = N.ORDER_ID AND ROWNUM =1;
         Vente := Vente + PRIX ;
        END LOOP; 
        
       
       
       DBMS_OUTPUT.PUT_LINE('le taux de vente pour l''employer '|| v_salesman|| ' est : ' ||(Vente/total_Vente)* 100||'%');
       
       
       
       
       DBMS_OUTPUT.PUT_LINE(' ***************************** fin ***************************** ');

END;
/

-- QUESTION 6 Pour un manager donnée (ID est a saisir) afficher le nombre de vente de ses employés (prévoir lecas où l’ID n’existe pas)


DECLARE

        v_salesman orders.salesman_id%type;
        v_MANAGER_ID EMPLOYEES.MANAGER_id%type;
        CURSOR C_ORDER IS
         SELECT * FROM orders WHERE salesman_id = v_salesman ;
        
        CURSOR C_EMPLOYEE IS
        SELECT * FROM EMPLOYEES  WHERE job_title = 'Sales Representative' AND EMPLOYEES.MANAGER_ID = v_MANAGER_ID; 
        
        J INTEGER := 0;
      
BEGIN
       DBMS_OUTPUT.PUT_LINE('**************************************************************** ');

    
       v_MANAGER_ID :='&v_MANAGER_ID';
        
        FOR M IN C_EMPLOYEE  LOOP   
          v_salesman := M.employee_id;
            IF v_salesman IS NULL THEN
              DBMS_OUTPUT.PUT_LINE(' MANAGER NOT FOUND !');
              EXIT;
            ELSE
        FOR N IN C_ORDER LOOP
        J := J+1;
        END LOOP; 
        DBMS_OUTPUT.PUT_LINE('le nombre de vente de l''employee '|| v_salesman || ' est : ' ||J);
        J :=0;
        END IF;
    END LOOP;
       DBMS_OUTPUT.PUT_LINE(' ***************************** fin ***************************** ');

END;

/


