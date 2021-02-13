-- Clase 8 - Cursores (parte A)
    -- Cursor Implícito
DECLARE
    NOMBRE PRODUCTS.PRODUCT_NAME%TYPE;
    ITERTACION NUMBER(10);
BEGIN
    SELECT PRODUCT_NAME INTO NOMBRE FROM PRODUCTS WHERE PRODUCT_ID=1;

    DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO CON ID 1 ES: '||NOMBRE);
    -- Utilizando variables con cursores implícitos (cursor implícito en oracle - SQL)
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||SQL%ROWCOUNT);
END;

    -- Cursor Explícito