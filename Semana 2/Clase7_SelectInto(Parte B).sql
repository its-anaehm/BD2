-- Podemos designar más variables a las que asignarles un valor a partir de una consulta.
DECLARE
	NOMBRE PRODUCTS.PRODUCT_NAME%TYPE;
	MODELO PRODUCTS.MODEL_YEAR%TYPE;
	PRECIO PRODUCTS.LIST_PRICE%TYPE;

BEGIN
	SELECT PRODUCT_NAME, MODEL_YEAR, LIST_PRICE INTO NOMBRE, MODELO, PRECIO 
		FROM PRODUCTS
		WHERE PRODUCT_ID=1;

	DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES: '||NOMBRE);
	DBMS_OUTPUT.PUT_LINE('EL MODELO DEL PRODUCTO ES: '||MODELO);
	DBMS_OUTPUT.PUT_LINE('EL PRECIO DEL PRODUCTO ES: '||PRECIO);

END;