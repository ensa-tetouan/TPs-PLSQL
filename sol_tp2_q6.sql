set serveroutput on; --CHABOU SOUFIAN GI2


DECLARE
     id_manager employees.manager_id%type; 
   
    CURSOR C_manager is 
     select count(*) as total from employees inner join orders on orders.salesman_id = employees.employee_id and orders.status = 'Shipped' and employees.job_title ='Sales Representative' and employees.manager_id = id_manager ;
  
 
BEGIN
    id_manager := '&id_manager';
    for n in C_manager  loop
    
          dbms_output.put_line('le nombre des vente des employee de manager : '||id_manager ||' est : '||n.total);
          
    end loop;



END;