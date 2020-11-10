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