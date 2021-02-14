  -- Haciendo uso de Funciones del sistema para fecha y hora
  /*
  -- ! FUNCIONES:
  -- *SYSDATE: PARA FECHA
  -- *SYSTIMESTAMP: PARA FECHA Y HORA
  */
DECLARE
  FECHA DATE;
  FECHA_HORA TIMESTAMP;
BEGIN
  FECHA:=SYSDATE;
  DBMS_OUTPUT.PUT_LINE('LA FECHA OBTENIDA CON EL SYSDATE ES:'||FECHA);

  FECHA_HORA:=SYSTIMESTAMP;
  DBMS_OUTPUT.PUT_LINE('LA FECHA Y HORA OBTENIDA CON EL SYSTIMESTAMP ES:'||FECHA_HORA);
END;

    -- Haciendo uso de la función USER y Funciones para fecha y hora
  /*
  -- ! FUNCIONES:
  -- *TO_DATE: PARA FECHA
  -- *TO_TIMESTAMP: PARA FECHA Y HORA
  -- *TO_CHAR: PARA CONVERTIRLO AL FORMATO DESEADO
  -- *USERS: PARA SABER CON QUE USUARIO SE ESTÁ HACIENDO LA CONEXION
  */
DECLARE
  FECHA DATE;
  FECHA_HORA TIMESTAMP;
BEGIN
  FECHA:=SYSDATE;
  DBMS_OUTPUT.PUT_LINE('LA FECHA OBTENIDA CON EL SYSDATE ES:'||FECHA);
  
  FECHA_HORA:=SYSTIMESTAMP;
  DBMS_OUTPUT.PUT_LINE('LA FECHA Y HORA OBTENIDA CON EL SYSTIMESTAMP ES:'||FECHA_HORA);
  
  FECHA:=TO_DATE('2018-05-28', 'YYYY-MM-DD');
  DBMS_OUTPUT.PUT_LINE('LA FECHA ASIGNADA CON TO_DATE ES:'||FECHA);
  FECHA_HORA:=TO_TIMESTAMP('25-02-2020 23:30:16', 'DD-MM-YYYY HH24:MI:SS');
  DBMS_OUTPUT.PUT_LINE('LA FECHA Y HORA ASIGNADA CON TO_TIMESTAMP ES:'||FECHA_HORA);
  
  DBMS_OUTPUT.PUT_LINE('USO DE TO_CHAR PARA COMBIAR EL FORMATO DE IMPRESION DE FECHA:'||TO_CHAR(FECHA,'DD-MM-YYYY'));
  DBMS_OUTPUT.PUT_LINE('USO DE TO_CHAR PARA COMBIAR EL FORMATO DE IMPRESION DE FECHA:'||TO_CHAR(FECHA_HORA,'DD-MM-YYYY HH-MI-SS AM'));
  
  DBMS_OUTPUT.PUT_LINE('EL USUARIO CONECTADO ES:'||USER);
END;

    -- Consultas haciendo uso de funciones
    -- ! FUNCIONES: TO_CHAR, TO_DATE, TO_TIMESTAMP
SELECT ORDER_DATE, TO_CHAR(TO_DATE(ORDER_DATE, 'YYYYMMDD'), 'YYYY-MM-DD'), TO_TIMESTAMP(ORDER_DATE, 'YYYYMMDD HH:MI:SS') FROM ORDERS;

    -- Consulta para obtener una subcadena a partir de una cadena
    -- ! FUNCIÓN: SUBSTR
SELECT CATEGORY_NAME, SUBSTR(CATEGORY_NAME, 3,5) FROM CATEGORIES;