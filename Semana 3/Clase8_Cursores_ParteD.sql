-- Cursores y arreglos asociados
    -- Utilizando un record o una tabla creada en base a un record o en base a un mapeo de los registros de la base de datos.
DECLARE
	TYPE TABLA_CATEGORIAS IS TABLE OF CATEGORIES%ROWTYPE INDEX BY PLS_INTEGER;
	DATOS_CATEGORIA TABLA_CATEGORIAS;
	ITERACION NUMBER(10):=0;

BEGIN
	SELECT CATEGORIES.CATEGORY_ID, CATEGORIES.CATEGORY_NAME BULK COLLECT INTO DATOS_CATEGORIA FROM CATEGORIES;
	DBMS_OUTPUT.PUT_LINE("La cantidad de registros es: "||SQL%ROWCOUNT);

	WHILE (ITERACION<SQL&ROWCOUNT) LOOP
		DBMS_OUTPUT.PUT_LINE("EL CÓDIGO DE LA CATEGORIA ES "||DATOS_CATEGORIA(ITERACION+1).CATEGORY_ID);
		DBMS_OUTPUT.PUT_LINE("EL NOMBRE DE LA CATEGORIA ES "||DATOS_CATEGORIA(ITERACION+1).CATEGORY_NAME);
		ITERACION:=ITERACION+1;
	END LOOP;
END;

    -- Utilizando arreglos asociativos
DECLARE
    TYPE ARREGLO IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    DATOS ARREGLO;
BEGIN
    DATOS(1):='ELEMENTO 1';
    DATOS(2):='ELEMENTO 2';
    DATOS(3):='ELEMENTO 3';
    DATOS(4):='ELEMENTO 4';
    DATOS(5):='ELEMENTO 5';
    DATOS(6):='ELEMENTO 6';

    FOR ITERACION IN 1..DATOS.COUNT LOOP -- DATOS.COUNT= LA FUNCION COUNT RETORNA EL TOTAL DE LOS ELEMENTOS DEL ARRELO.
    DBMS_OUTPUT.PUT_LINE(DATOS(ITERACION));
    END LOOP;END;

SET SERVEROUTPUT ON;

    -- Haciendo uso de las funciónes PRIOR y NEXT para hacer referencias a posiciones en los arreglos 
DECLARE
    TYPE ARREGLO IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    DATOS ARREGLO;
BEGIN
    DATOS(1):='ELEMENTO 1';
    DATOS(2):='ELEMENTO 2';
    DATOS(3):='ELEMENTO 3';
    DATOS(4):='ELEMENTO 4';
    DATOS(5):='ELEMENTO 5';
    DATOS(6):='ELEMENTO 6';

    FOR ITERACION IN 1..DATOS.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(DATOS(ITERACION));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(DATOS.PRIOR(3));
    DBMS_OUTPUT.PUT_LINE(DATOS.NEXT(3));

END;

    -- Haciendo uso de la función DELETE para borrar elemntos de los arreglos.
DECLARE
    TYPE ARREGLO IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    DATOS ARREGLO;
BEGIN
    DATOS(1):='ELEMENTO 1';
    DATOS(2):='ELEMENTO 2';
    DATOS(3):='ELEMENTO 3';
    DATOS(4):='ELEMENTO 4';
    DATOS(5):='ELEMENTO 5';
    DATOS(6):='ELEMENTO 6';

    FOR ITERACION IN 1..DATOS.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(DATOS(ITERACION));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(DATOS.PRIOR(3));
    DBMS_OUTPUT.PUT_LINE(DATOS.NEXT(3));

    DATOS.DELETE(1);
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE VALORES ES: '||DATOS.COUNT);

END;

    -- DELETE con dos parametros: Elimina los elementos dentro del rango de valores desde a hasta b
DECLARE
    TYPE ARREGLO IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    DATOS ARREGLO;
BEGIN
    DATOS(1):='ELEMENTO 1';
    DATOS(2):='ELEMENTO 2';
    DATOS(3):='ELEMENTO 3';
    DATOS(4):='ELEMENTO 4';
    DATOS(5):='ELEMENTO 5';
    DATOS(6):='ELEMENTO 6';

    FOR ITERACION IN 1..DATOS.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(DATOS(ITERACION));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(DATOS.PRIOR(3));
    DBMS_OUTPUT.PUT_LINE(DATOS.NEXT(3));

    DATOS.DELETE(1);
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE VALORES ES: '||DATOS.COUNT);

    DATOS.DELETE(2,4);
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE VALORES ES: '||DATOS.COUNT);

END;