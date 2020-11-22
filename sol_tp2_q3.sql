SET SERVEROUTPUT ON; -- CHABOU SOUFIAN GI2

DECLARE 

    id_customer orders.customer_id%type;
    I INTEGER :=0;
    CURSOR C_customer is 
    select DISTINCT(CUSTOMER_ID) FROM CUSTOMERS;
    
    
    cursor C_shipped is
    select sum(order_items.unit_price) AS total from orders inner join order_items on orders.order_id = order_items.order_id  and orders.customer_id = id_customer and orders.status = 'Shipped';
    
    
BEGIN
    FOR M IN C_customer LOOP
    id_customer :=M.CUSTOMER_ID;
       for N in C_shipped loop
       
       if N.total is null then
        DBMS_OUTPUT.PUT_LINE('customer :'||id_customer||' ->  0$');
       else
         DBMS_OUTPUT.PUT_LINE('customer :'||id_customer||' ->  '|| N.total||'$');
         if N.total > 2000 then
         UPDATE customers
         SET CREDIT_LIMIT = CREDIT_LIMIT + 50;
         
         IF SQL%NOTFOUND THEN
         DBMS_OUTPUT.PUT_LINE('NO CUSTOMERS SELECTED ');
         ELSIF SQL%FOUND THEN
         I:=I + 1;
         END IF;
         
         end if;
     end if;
     
     END LOOP;
     
 end loop;

     DBMS_OUTPUT.PUT_LINE('LE NOMBRE DES LIGNE QUI EN ETE MISE A JOUR : '|| I);

END;