SET SERVEROUTPUT ON;

DECLARE
CURSOR C1 IS SELECT * FROM ORDERS WHERE CUSTOMER_ID='&id';

TYPE order_list IS TABLE OF ORDERS%ROWTYPE;
v_orders order_list := order_list();
n integer := 0;
BEGIN

FOR n_C1 IN C1 LOOP 
n := n +1;
v_orders.extend;
v_orders(N) := n_C1;
--DBMS_OUTPUT.PUT_LINE( v_orders(i).STATUS ||  v_orders(i).ORDER_DATE);
END LOOP;
FOR i IN 1 .. v_orders.COUNT LOOP
DBMS_OUTPUT.PUT_LINE( v_orders(i).STATUS || ' ' ||  v_orders(i).ORDER_DATE);
END LOOP;
END;
