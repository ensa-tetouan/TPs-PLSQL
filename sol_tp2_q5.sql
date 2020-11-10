SET SERVEROUTPUT ON;    
-- CHABOU SOUFIAN GI2 --



-- QUESTION  5 :Ecrire un curseur permettant d’afficher le taux de vente d’un employé entre deux dates. Les dates sont à saisir par l’utilisateur (ne pas utiliser les curseurs paramétrés)

DECLARE

        v_salesman orders.salesman_id%type;
        date_debut date;
        date_fin date;
        CURSOR C_ORDER2 IS
         SELECT * FROM orders WHERE salesman_id = v_salesman ;
         
        CURSOR C_ORDER IS
         SELECT * FROM orders WHERE salesman_id = v_salesman and order_date >= date_debut  and  order_date <= date_fin;
        
        CURSOR C_EMPLOYEE IS
        SELECT * FROM EMPLOYEES  WHERE job_title = 'Sales Representative';
        
        total_Vente order_items.unit_price%TYPE :=0;
        Vente order_items.unit_price%TYPE :=0;
        PRIX order_items.unit_price%TYPE :=0;



        J INTEGER := 0;
      
BEGIN
       DBMS_OUTPUT.PUT_LINE('**************************************************************** ');
 
       date_debut:='&date_debut';
       date_fin:='& date_fin';
       
    FOR M IN C_EMPLOYEE  LOOP
          v_salesman := M.employee_id;
          
        FOR N IN C_ORDER LOOP
        J := J+1;
         SELECT unit_price INTO PRIX FROM order_items  WHERE order_items.order_id = N.ORDER_ID AND ROWNUM =1;
         total_Vente := total_Vente + PRIX ;
        END LOOP; 
        IF J > 0 THEN
        DBMS_OUTPUT.PUT_LINE('le nombre de vente de l''employee '|| v_salesman || ' est : ' ||J);
        
        END IF;
        J :=0;
     
      END LOOP;
       DBMS_OUTPUT.PUT_LINE('le chiffre d''affaire total de cette periode : '||total_Vente||'$');
       
       
       
        v_salesman:='&v_salesman';

       
        FOR N IN C_ORDER LOOP
         SELECT unit_price INTO PRIX FROM order_items  WHERE order_items.order_id = N.ORDER_ID AND ROWNUM =1;
         Vente := Vente + PRIX ;
        END LOOP; 
        
       
       
       DBMS_OUTPUT.PUT_LINE('le taux de vente pour l''employer '|| v_salesman|| ' est : ' ||(Vente/total_Vente)* 100||'%');
       
       
       
       
       DBMS_OUTPUT.PUT_LINE(' ***************************** fin ***************************** ');

END;
/