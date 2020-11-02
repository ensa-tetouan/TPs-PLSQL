--question 1


DECLARE
  v_nom varchar(250);
  v_prenom varchar(250);
BEGIN
  v_nom := '&v_nom'; 
  v_prenom := '&v_prenom';
  dbms_output.put_line('votre nom= ' || v_nom) ;
  dbms_output.put_line('votre prenom= ' || v_prenom) ;
END; 

--question2

SET SERVEROUTPUT ON ;
DECLARE
emp_nbr INTEGER ;
BEGIN
SELECT COUNT(*)
into emp_nbr 
FROM EMPLOYEES ;
dbms_output.put_line(emp_nbr);
END;

--question 3

SET SERVEROUTPUT ON ;
DECLARE
emp_nbr_man INTEGER ;
BEGIN
SELECT COUNT(EMPLOYEE_ID)
into emp_nbr_man 
FROM EMPLOYEES 
WHERE MANAGER_ID = 1 ;
dbms_output.put_line(emp_nbr_man);
END;

--question 4

SET SERVEROUTPUT ON ;
DECLARE
emp_nbr INTEGER ;
emp_nbr_man INTEGER ;
prop INTEGER ;
BEGIN
SELECT COUNT(*)
into emp_nbr 
FROM EMPLOYEES ;
SELECT COUNT(EMPLOYEE_ID)
into emp_nbr_man 
FROM EMPLOYEES 
WHERE MANAGER_ID = 1 ;
prop := (emp_nbr_man/emp_nbr)*100 ;
dbms_output.put_line(prop);
END;

--question 5

set serverout on ;
DECLARE
  v_last_name varchar(250);
  v_first_name varchar(250);
  v_hire_date varchar(250);
BEGIN
  SELECT LAST_NAME, FIRST_NAME , HIRE_DATE 
  into v_last_name , v_first_name , v_hire_date
  FROM EMPLOYEES 
  where EMPLOYEE_ID = 1 ; 
  dbms_output.put_line(v_last_name) ;
  dbms_output.put_line(v_first_name) ;
  dbms_output.put_line(v_hire_date) ;
END;

--question 6

set serverout on ;
DECLARE
 type employee 
 is record (
  v_last_name varchar(250) ,
  v_first_name varchar(250),
  v_hire_date varchar(250)
  ) ;
  emp employee ;
  
BEGIN
  SELECT LAST_NAME, FIRST_NAME , HIRE_DATE 
  into emp.v_last_name , emp.v_first_name , emp.v_hire_date
  FROM EMPLOYEES 
  where   EMPLOYEE_ID ='&EMPLOYEE_ID';
  dbms_output.put_line(
  'votre last name =' || emp.v_last_name || 
  ' , votre first name =' || emp.v_first_name ||
  ' , votre Hire Date =' || emp.v_hire_date ) ;
END;

--question 7

set serverout on ;
DECLARE
 type product 
 is record (
  product_id NUMBER ,
  product_name varchar(250),
  descriptionn VARCHAR(2000),
  standard_cost NUMBER(9,2),
  list_price NUMBER(9,2),
  category_id NUMBER
  ) ;
  prod product;
  
BEGIN
  dbms_output.put_line('entrer le produit') ;
  SELECT *
  into prod.product_id,prod.product_name , prod.descriptionn , prod.standard_cost 
  , prod.list_price , prod.category_id
  FROM PRODUCTS
  where   PRODUCT_ID ='&PRODUCT_ID';
  dbms_output.put_line(
  'prod id =' || prod.product_id || 
  ' , prod_name =' ||prod.product_name ||
  ' , description =' || prod.descriptionn ||
  ' , standard cost =' || prod.standard_cost ||
  ' , list price =' || prod.list_price ||
  ' , category id =' || prod.category_id 
) ;
END;

--question 8

set serveroutput on ;
DECLARE 
type managerr
is RECORD 
(
manager_id NUMBER(12,0) ,
job_title VARCHAR2(255 BYTE) 
) ;
mgr managerr;
type employee
is RECORD 
(
employee_id NUMBER ,
first_name VARCHAR2(255 BYTE),
last_name VARCHAR2(255 BYTE) ,
email VARCHAR2(255 BYTE),
phone VARCHAR2(255 BYTE) ,
hire_date Date
) ;
emp employee;
begin
  SELECT *
  into emp.employee_id , emp.first_name ,emp.last_name , emp.email,
  emp.phone, emp.hire_date ,
  mgr.manager_id,mgr.job_title 
  FROM EMPLOYEES
  where   EMPLOYEE_ID ='&EMPLOYEE_ID';
  dbms_output.put_line(
  'employee =' ||emp.employee_id || 
  ' , first name =' || emp.first_name ||
  ' , last name =' || emp.last_name ||
  ' , email =' ||  emp.email ||
  ' , phone =' || emp.phone ||
  ' , hire_date =' || emp.hire_date  ||
  ' , manager =' || mgr.manager_id  ||
  ' , job title =' || mgr.job_title  
) ;

end ;
