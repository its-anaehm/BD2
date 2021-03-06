-- Clase 8 - Cursores (parte B)

    -- Cursor que devuelve más de un resultado

DECLARE
	NOMBRE_PRODUCTO PRODUCTS.PRODUCT_NAME%TYPE;
	MODELO_PRODUCTO PRODUCTS.MODEL_YEAR%TYPE;
	NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE;
	CURSOR CDATOS_PRODUCTO IS SELECT PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME, PRODUCTS.MODEL_YEAR FROM PRODUCTS INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY;

BEGIN
	OPEN CDATOS_PRODUCTO;

	LOOP
		FETCH CDATOS_PRODUCTO INTO NOMBRE_PRODUCTO, MODELO_PRODUCTO, NOMBRE_CATEGORIA;
		DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES:'||NOMBRE_PRODUCTO);
		DBMS_OUTPUT.PUT_LINE('EL MODELO DEL PRODUCTO ES:'||MODELO_PRODUCTO);
		DBMS_OUTPUT.PUT_LINE('LA CATEGORIA DEL PRODUCTO ES:'||NOMBRE_CATEGORIA);
		DBMS_OUTPUT.PUT_LINE(CHR(13)); -- Imprime un salto de línea.
		DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||CNOMBRE_PRODUCTO%ROWCOUNT);

	END LOOP;

	CLOSE CDATOS_PRODUCTO;

END;

    -- Utilizando una menor cantidad de variables
DECLARE	
	CURSOR CDATOS_PRODUCTO IS 
		SELECT PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME, PRODUCTS.MODEL_YEAR  FROM PRODUCTS  INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY; 
        REGISTRO CDATOS_PRODUCTO%ROWTYPE;
	-- Esta variable toma cada uno de los campos especificados en el cursor, según el tipo de cada uno.
	-- Si se declaran campos con aliases, se debe hacer referencia directa al alias respectivo de cada campo.

BEGIN
	OPEN CDATOS_PRODUCTO;

	LOOP
		FETCH CDATOS_PRODUCTO INTO REGISTRO;
		DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES:'||REGISTRO.PRODUCT_NAME);
		DBMS_OUTPUT.PUT_LINE('EL MODELO DEL PRODUCTO ES:'||REGISTRO.MODEL_YEAR);
		DBMS_OUTPUT.PUT_LINE('LA CATEGORIA DEL PRODUCTO ES:'||REGISTRO.CATEGORY_NAME);
		DBMS_OUTPUT.PUT_LINE(CHR(13)); -- Imprime un salto de línea.

		-- Los campos con nombres iguales hay que diferenciarlos con un alias.

	END LOOP;

	DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||CNOMBRE_PRODUCTO%ROWCOUNT);
	CLOSE REGISTRO;

END;