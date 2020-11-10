SET SERVEROUTPUT ON;    
-- CHABOU SOUFIAN GI2 --



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


