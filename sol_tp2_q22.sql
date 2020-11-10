SET SERVEROUTPUT ON;    
-- CHABOU SOUFIAN GI2 --


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
