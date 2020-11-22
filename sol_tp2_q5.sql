SET SERVEROUTPUT ON; --CHABOU SOUFIAN GI2


DECLARE
    id_salseman orders.salesman_id%type := '&id_salseman';
    init_date orders.order_date%type := '&init_date';
    end_date orders.order_date%type := '&end_date';
    
    TOTAL order_items.unit_price%type;
    cursor c_vente is 
    select sum(order_items.unit_price) as T FROM orders inner join order_items on orders.order_id = order_items.order_id and orders.salesman_id = id_salseman and orders.status = 'Shipped' and (orders.order_date > init_date and orders.order_date < end_date);
    
BEGIN
        select sum(order_items.unit_price) INTO TOTAL FROM orders inner join order_items on orders.order_id = order_items.order_id;
    for N in c_vente loop
        dbms_output.put_line('les vente efectue par le salse man : '||N.T);
         dbms_output.put_line('le taux : '|| N.T/total * 100);
    end loop;
    

END;