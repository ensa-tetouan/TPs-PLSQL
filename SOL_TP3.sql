------------------------------------------------------
------------------------------------------------------
------------------------------------------------------
 --EXERCICE 1 (Les procédures)
 SET SERVEROUTPUT ON;
 -- 1) Ecrire une Procédure qui ajoute un WAREHOUSE pour une location donnée.
DECLARE 
a number;
PROCEDURE WAREHOUSE_ADD(x in number) AS
BEGIN
      INSERT INTO warehouses(warehouse_name,location_id) SELECT city, location_id FROM locations WHERE location_id = X;
	  -- On remarque que le warehouse_name referencie le nom de la ville dans la table locations, du coup
	  -- on recupere le nom de la ville et location_id, et on les insere dans la table warehouses
	  -- Pas besoin d'inserer le warehouse_id, parce qu'il s'incremente automatiquementhf
END WAREHOUSE_ADD;
BEGIN
      DBMS_OUTPUT.PUT_LINE('ENTER LOCAL ID:');
      a:='&a';
      WAREHOUSE_ADD(a);
      END;

 -- 2) Ecrire une procédure qui met à jour les données relatives à une WAREHOUSE d’une location donnée.
 SET SERVEROUTPUT ON;
DECLARE 
a NUMBER;
b VARCHAR2(255);
PROCEDURE WAREHOUSE_UPDATE(X IN NUMBER, Y IN VARCHAR) AS 
BEGIN
     UPDATE warehouses 
     SET warehouse_name=Y, location_id=X WHERE location_id=X;
END WAREHOUSE_UPDATE;
BEGIN
     DBMS_OUTPUT.PUT_LINE('Veuillez saisir location ID: ');
	 a:='&a';
     DBMS_OUTPUT.PUT_LINE('Veuillez saisir la localisation du nouveau entrepot: ');
	 b:='&b';
	 WAREHOUSE_UPDATE(a,b);
END;

-- 3) Ecrire une procédure qui permet de supprimer un WAREHOUSE données.
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE WAREHOUSE_DELETE(a IN NUMBER) IS
BEGIN
   DELETE FROM warehouses WHERE warehouse_id=a;
END WAREHOUSE_DELETE;
-- Pour executer cette procedure il suffit de taper la commande suivante (par exemple, je souhaite supprimer le warehouse dont l'id = 10
EXECUTE WAREHOUSE_DELETE(10);

-- 5) Ecrire une procédure calcule le CA d’un employé.
SET SERVEROUTPUT ON;
DECLARE
a NUMBER;
b NUMBER;
first_name VARCHAR2(255);
last_name VARCHAR2(255);
PROCEDURE employee_CA(id_employee IN NUMBER, CA OUT NUMBER) IS
BEGIN
SELECT SUM(order_items.quantity*order_items.unit_price) INTO CA
          FROM order_items 
          JOIN orders ON order_items.order_id=orders.order_id
          WHERE (orders.salesman_id=id_employee AND orders.status='Shipped')
          -- Les commandes de chaque vendeur sont divisées en trois catégories (Expédié(Shipped), en attente(Pending) ou annulée(Canceled)).
          -- La transaction du CA n'est effectuée qu'après la fin du processus d'expédition et de livraison. 
          order BY orders.salesman_id;
END employee_CA;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Entrer l''ID de l''employé: ');
   a:='&a';
   SELECT employees.first_name, employees.last_name INTO first_name, last_name FROM employees WHERE employees.employee_id=a;
   employee_CA(a,b);
   DBMS_OUTPUT.PUT_LINE('Le CA de l''employé '||first_name||' '||last_name||' est: '||b||' $');
   -- Si on demmande le chiffre d'affaire de l'employé ayant l'ID 57, on reçoit le message ci-dessous:
   -- Le CA de l'employé Scarlett Gibson est: 1449811.86 $
END;
------------------------------------------------------
------------------------------------------------------
------------------------------------------------------

--EXERCICE 2 (Les fonctions) 
-- 1) Ecrire une fonction retournant le prix total d’une commande d’un client.
SET SERVEROUTPUT ON;
DECLARE 
a number;
b number;
TYPE prix_total IS 
RECORD(
   Customer orders.customer_id%TYPE,
   Order_ID order_items.order_id%TYPE,
   Item_ID order_items.item_id%TYPE,
   Total_Price order_items.unit_price%TYPE
   );
v_result prix_total;
FUNCTION total_price_command(X IN order_items.order_id%type, Y IN order_items.item_id%type)RETURN prix_total IS
-- Les entrées de la fonction doivent porter le même type que celui des attributs de la table sur laquelle on travaille: 
commande prix_total;
BEGIN
          SELECT orders.customer_id, order_items.order_id, order_items.item_id, order_items.quantity*order_items.unit_price
          INTO commande
          FROM orders 
          JOIN order_items ON order_items.order_id=orders.order_id
          WHERE (order_items.order_id=X AND order_items.item_id=Y)
          ORDER BY orders.customer_id;
          RETURN commande;
END;
BEGIN
a:='&a';
b:='&b';
v_result:=total_price_command(a,b);

DBMS_OUTPUT.PUT_LINE('Customer: '||v_result.Customer);
DBMS_OUTPUT.PUT_LINE('Order ID: '||v_result.Order_ID);
DBMS_OUTPUT.PUT_LINE('Item ID: '||v_result.Item_ID);
DBMS_OUTPUT.PUT_LINE('Total price: '||v_result.Total_Price);
END;

-- 2) Ecrire une fonction retournant le nombre de commande qui ont le statut : Pending.
SET SERVEROUTPUT ON;
DECLARE
a orders.status%type;
b NUMBER;
FUNCTION count_order_pending(order_status orders.status%type) RETURN NUMBER IS
-- Cette fonction prend comme paramètre le statut de la commande pour laquelle on souhaite calculer le nombre d'occurence
-- Par exemple si on donne comme paramètre Shipped ça va afficher 71
-- Pour Pending, l'output est: 
-- Le nombre de commandes qui ont le statut Pending est: ----- 18 -----
k NUMBER;
BEGIN
  SELECT
      COUNT(*) "COUNT(*)"
  INTO k
  FROM
      "OT"."ORDERS" "A1"
  WHERE
      "A1"."STATUS" = order_status;
  RETURN k;
END;
BEGIN
  a:='&a';
  b:=count_order_pending(a);
  DBMS_OUTPUT.PUT_LINE('Le nombre de commandes qui ont le statut '||a||' est: ----- '||b||' -----');
END;


