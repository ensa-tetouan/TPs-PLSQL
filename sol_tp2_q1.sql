SET SERVEROUTPUT ON; -- CHABOU SOUFIAN GI2

DECLARE

CURSOR C_EMPLOYEE IS
SELECT * FROM EMPLOYEES;

v_var varchar2(50);

BEGIN

    FOR N IN C_EMPLOYEE LOOP
    if N.MANAGER_ID is NOT null then
       select employees.Last_name into v_var from employees where EMPLOYEE_ID = N.MANAGER_ID ;
    
        DBMS_OUTPUT.PUT_LINE('FIRST NAME : '||N.First_name || ' - LAST_NAME : '||N.LAST_NAME||' - ID : '||N.EMPLOYEE_ID || ' - Travaille comme : '||N.JOB_TITLE || ' - Depuis : '||N.HIRE_DATE || ' - sous la direction de : '|| v_var);
    else
     
             DBMS_OUTPUT.PUT_LINE('FIRST NAME : '||N.First_name || ' - LAST_NAME : '||N.LAST_NAME||' - ID : '||N.EMPLOYEE_ID || ' - Travaille comme : '||N.JOB_TITLE || ' - Depuis : '||N.HIRE_DATE || ' - Le presidant ');
     
    end if;
    
    END LOOP;


END;