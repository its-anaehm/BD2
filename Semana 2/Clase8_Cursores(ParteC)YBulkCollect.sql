-- Clase 8 - Cursores (parte C) y Bulk Collect

	-- Haciendo uso de una estructura de tipo Record, y de Bulk Collect.
DECLARE
	TYPE FILA IS RECORD(
		NOMBRE_PRODUCTO PRODUCTS.PRODUCT_NAME%TYPE,
		NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE,
		ANIO_MODELO NUMBER,
		COD_CATEGORIA NUMBER		
	);
	-- FILA  está guardando un registro de cuatro campos.

	CURSOR CDATOS_PRODUCTO IS 
		SELECT PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME, PRODUCTS.MODEL_YEAR, CATEGORIES.CATEGORY_ID, FROM PRODUCTS INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY;
	-- REGISTRO CDATOS_PRODUCTO%ROWTYPE;	
	DATOS_CURSOR FILA;

BEGIN
	OPEN CDATOS_PRODUCTO;

	LOOP
		FETCH CDATOS_PRODUCTO INTO DATOS_CURSOR;
		-- A continuación, se hace referencia a los campos del registro FILA.
		DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES:'||DATOS_CURSOR.NOMBRE_PRODUCTO);
		DBMS_OUTPUT.PUT_LINE('EL MODELO DEL PRODUCTO ES:'||DATOS_CURSOR.ANIO_MODELO);
		DBMS_OUTPUT.PUT_LINE('LA CATEGORIA DEL PRODUCTO ES:'||DATOS_CURSOR.NOMBRE_CATEGORIA);
		DBMS_OUTPUT.PUT_LINE('EL CÓDIGO DE CATEGORIA DEL PRODUCTO ES:'||DATOS_CURSOR.COD_CATEGORIA);
		DBMS_OUTPUT.PUT_LINE(CHR(13)); -- Imprime un salto de línea.	

	END LOOP;

	DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||CNOMBRE_PRODUCTO%ROWCOUNT);
	CLOSE REGISTRO;

END;

    -- Se hace uso de un Bulk Collect cuando se quieren obtener registros de una consulta a la vez en unsa sola petición, para poder agilizar el código. Básicamente, guardan varios registros de tipo RECORD. Multiples registros en una sola variable.Bulk Collect usa un cursor implicito.

DECLARE
	TYPE FILA IS RECORD(
		CODIGO_CATEGORIA CATEGORIES.CATEGORY_ID%TYPE,
		NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE,		
	);

	TYPE TABLA_CATEGORIAS IS TABLE OF FILA INDEX BY PLS_INTEGER;
	DATOS_CATEGORIA TABLA_CATEGORIAS;
	ITERACION NUMBER(10):=0;

BEGIN
	SELECT CATEGORIES.CATEGORY_ID, CATEGORIES.CATEGORY_NAME BULK COLLECT INTO DATOS_CATEGORIA FROM CATEGORIES;
	DBMS_OUTPUT.PUT_LINE("La cantidad de registros es: "||SQL%ROWCOUNT);

	WHILE (ITERACION<SQL&ROWCOUNT) LOOP
		DBMS_OUTPUT.PUT_LINE("EL CÓDIGO DE LA CATEGORIA ES "||DATOS_CATEGORIA(ITERACION+1).CODIGO_CATEGORIA);
		DBMS_OUTPUT.PUT_LINE("EL NOMBRE DE LA CATEGORIA ES "||DATOS_CATEGORIA(ITERACION+1).NOMBRE_CATEGORIA);
		ITERACION:=ITERACION+1;
	END LOOP;
END;