QUESTION 1:
declare 
v_nom VARCHAR(25);
v_prenom VARCHAR(25);
BEGIN
v_nom:= '$v_nom';
v_prenom:= '$v_prenom';
dbms_output.put_line(' le nom :' || v_nom );
dbms_output.put_line(' le prenom :' || v_prenom );
end;
QUESTION 2:
declare
v_var1 NUMBER(4);
BEGIN
SELECT COUNT * INTO v_var1 FROM employees;
dbms_output.put_line('le nombre des employees est : ' || v_var1);
END;
QUESTION 3:
declare
v_var1 NUMBER(4);
BEGIN
SELECT COUNT * INTO v_var1 FROM employees WHERE manager_id=1;
dbms_output.put_line('le nombre des employees dont le manager id est 1 est : ' || v_var1);
END;
QUESTION 4:
DECLARE 
v_var1 NUMBER(4);
v_var2 NUMBER(4);
v_var3 NUMBER(4);
BEGIN
SELECT COUNT (*) INTO v_var1 FROM employees;
SELECT COUNT (*) INTO v_var2 FROM employees WHERE manager_id=1;
v_var3:= (v_var2 / v_var1)*100;
dbms_output.put_line('la proportion des employees : ' || v_var3 || '%');
END;
QUESTION 5:
DECLARE 
v_first_name VARCHAR(25);
v_last_name VARCHAR(25);
v_hire_date VARCHAR(25);
v_manager_id INT;
BEGIN
v_manager_id:='$v_manager_id';
dbms_output.put_line('Entrez l id du manager :' || v_manager_id);
SELECT first_name,last_name,hire_date INTO v_first_name,v_last_name,v_hire_date FROM employees WHERE manager_id=v_manager_id;
dbms_output.put_line('first_name : ' ||  v_first_name || '  last_name: ' ||  v_last_name || '  hire_date: ' || v_hire_date);
END;
QUESTION 6:
DECLARE 
v_record employees%ROWTYPE;
v_manager_id INT;
BEGIN
v_manager_id:='$v_manager_id';
dbms_output.put_line('Entrez l id du manager :' || v_manager_id);
SELECT * INTO v_record FROM employees WHERE manager_id=v_manager_id;
dbms_output.put_line('first_name : ' ||  v_record.first_name || '  last_name: ' ||  v_record.last_name || '  hire_date: ' || v_record.hire_date);
END;
QUESTION 7:
DECLARE 
v_record1 products%ROWTYPE;
v_procuct_id INT;
BEGIN
v_product_id:='$v_product_id';
dbms_output.put_line('Entrez l id de product :' || v_product_id);
SELECT * INTO v_record1 FROM products WHERE product_id=v_product_id;
dbms_output.put_line('product_name : ' ||  v_record1.product_name || '  descripton: ' ||  v_record1.description || ' standard_cost : ' 
|| v_record1.standard_cost || ' liste_price : ' || v_record1.liste_price);
END;
QUESTION 8:
DECLARE
r_mgr employees%ROWTYPE;
r_emp employees%ROWTYPE;
v_employee_id INT;
BEGIN
v_employee_id:='$v_employee_id';
dbms_output.put_line('Entrez l id de l employee :' || v_employee_id); 
SELECT * INTO r_mgr FROM employees WHERE employee_id=v_employee_id;
SELECT * INTO r_emp FROM employees WHERE employee_id=v_employee_id;
dbms_output.put_line(' first_name : ' || r_mgr.first_name || '  last_name : ' || r_mgr.last_name|| ' email  : ' || r_mgr.email  || '  phone : ' || r_mgr.phone || '  hire_date : ' || r_mgr.hire_date || '  job_title : ' || r_mgr.job_title|| '  manager_id  : ' || r_emp.manager_id );  
END;
QUESTION 9:
DECLARE
r_record1 orders%ROWTYPE;
r_record2 customers%ROWTYPE;
BEGIN
SELECT * INTO r_record1 FROM orders;
SELECT * INTO r_record2 FROM customers ;
dbms_output.put_line(' order_id : ' || r_record1.order_id || '  status  : ' || r_record1.status 
|| '   salesman_id : ' || r_record1.salesman_id  || '  order_date : ' || r_record1.order_date || '  customer_id : ' || r_record2.customer_id );
END;