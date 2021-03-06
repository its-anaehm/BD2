-- Ana Evelin Hernández Martínez - 20171001620

/*
    EJERCICIO #1: Crear una función para obtener todos los productos incluidos en una orden en específico, estos datos se 
    deben retornar en un cursor. Los campos que se deben obtener son ORDER_ID, PRODUCT_ID, PRODUCT_NAME, ORDER_TOTAL y 
    ORDER_TIMESTAMP.
*/

CREATE OR REPLACE FUNCTION FN_INF_ORDER(ID_ORDER DEMO_ORDERS.ORDER_ID%TYPE)
RETURN SYS_REFCURSOR
IS
    CORDENES SYS_REFCURSOR;
BEGIN
    OPEN CORDENES FOR 
    SELECT 
        DEMO_ORDERS.ORDER_ID, 
        DEMO_PRODUCT_INFO.PRODUCT_ID, 
        DEMO_PRODUCT_INFO.PRODUCT_NAME, 
        DEMO_ORDERS.ORDER_TOTAL, 
        DEMO_ORDERS.ORDER_TIMESTAMP 
    FROM DEMO_ORDERS
    LEFT JOIN DEMO_ORDER_ITEMS ON DEMO_ORDERS.ORDER_ID=DEMO_ORDER_ITEMS.ORDER_ID
    LEFT JOIN DEMO_PRODUCT_INFO ON DEMO_ORDER_ITEMS.PRODUCT_ID=DEMO_PRODUCT_INFO.PRODUCT_ID
    WHERE DEMO_ORDERS.ORDER_ID=ID_ORDER;
    RETURN CORDENES;
END;


/*
    EJERCICIO #2: Crear un procedimiento que haga uso de la función anterior para imprimir todos los registros que devuelve 
    la función.
*/

CREATE OR REPLACE PROCEDURE SP_FN_OBTENER_ORDER(COD_ORDER DEMO_ORDERS.ORDER_ID%TYPE)
IS
    DATOS_ORDER SYS_REFCURSOR;
    TYPE FILA IS RECORD(
        ORDER_ID DEMO_ORDERS.ORDER_ID%TYPE,
        PRODUCT_ID DEMO_PRODUCT_INFO.PRODUCT_ID%TYPE,
        PRODUCT_NAME DEMO_PRODUCT_INFO.PRODUCT_NAME%TYPE,
        ORDER_TOTAL DEMO_ORDERS.ORDER_TOTAL%TYPE,
        ORDER_TIMESTAMP DEMO_ORDERS.ORDER_TIMESTAMP%TYPE
    );
    REGISTRO FILA;
BEGIN
    DATOS_ORDER := FN_INF_ORDER(5);
    LOOP 
        FETCH DATOS_ORDER INTO REGISTRO;
        EXIT WHEN DATOS_ORDER%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ORDER_ID: '|| REGISTRO.ORDER_ID);
        DBMS_OUTPUT.PUT_LINE('PRODUCT_ID: '|| REGISTRO.PRODUCT_ID);
        DBMS_OUTPUT.PUT_LINE('PRODUCT_NAME: '|| REGISTRO.PRODUCT_NAME);
        DBMS_OUTPUT.PUT_LINE('ORDER_TOTAL: '|| REGISTRO.ORDER_TOTAL);
        DBMS_OUTPUT.PUT_LINE('ORDER_TIMESTAMP: '|| REGISTRO.ORDER_TIMESTAMP);
        DBMS_OUTPUT.PUT_LINE(CHR(13));
    END LOOP;
END;

-- Ejecución del ejercicio 2
DECLARE 
BEGIN
    SP_FN_OBTENER_ORDER(5);
END;


/*
    EJERCICIO #3: Crear un procedimiento que le asigne un valor de 300 a todos aquellos usuarios que todavía no tienen establecido un valor en el campo QUOTA, en caso de que suceda un error deshacer todos los cambios y en caso de éxito entonces se deben aprobar los cambios realizados. El valor de la quota debe ser pasado como parámetro del procedimiento.
*/

CREATE OR REPLACE PROCEDURE SP_USERS_QUOTA (QUOTA OUT DEMO_USERS.QUOTA%TYPE)
IS
BEGIN 
    UPDATE DEMO_USERS SET QUOTA = 300 WHERE QUOTA IS NULL;
    COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
END;

--- Ejecución del ejercicio 3
DECLARE 
    QUOTA_VALOR DEMO_USERS.QUOTA%TYPE;
BEGIN
    SP_USERS_QUOTA(QUOTA_VALOR);
END;


/*
    EJERCICIO 4: Crear un procedimiento almacenado que inserte registros en la tabla empleados, los datos del empleado deben ser enviados como parámetros 
    del procedimiento. Controlar cualquier error que se produzca en el procedimiento y deshacer los cambios, si todo está bien, entonces aprobar los cambios. 
*/

CREATE OR REPLACE PROCEDURE SP_INSERT_EMPLOYEES(PNOMBRE EMPLOYEES.FIRST_NAME%TYPE, SAPELLIDO EMPLOYEES.LAST_NAME%TYPE, CORREO EMPLOYEES.EMAIL%TYPE,
TELEFONO EMPLOYEES.PHONE_NUMBER%TYPE, FECHA EMPLOYEES.HIRE_DATE%TYPE, ID_TRABAJO EMPLOYEES.JOB_ID%TYPE, SALARIO EMPLOYEES.SALARY%TYPE, COMISIONES EMPLOYEES.COMMISSION_PCT%TYPE,
ID_GERENTE EMPLOYEES.MANAGER_ID%TYPE, ID_DEPARTAMENTO EMPLOYEES.DEPARTMENT_ID%TYPE)
IS
BEGIN 
    INSERT INTO EMPLOYEES (FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) 
    VALUES (PNOMBRE, SAPELLIDO, CORREO, TELEFONO, FECHA, ID_TRABAJO, SALARIO, COMISIONES, ID_GERENTE, ID_DEPARTAMENTO);
    COMMIT;
    
    EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK;
END;


-- Realizando la prueba con un INSERT
BEGIN
    SP_INSERT_EMPLOYEES('Roger', 'Martinez', 'rogermartinez@rm.com', '99887766', SYSDATE, 'SA_REP', 11000, 0.12, 149, 80);
END;

------ SEQUENCE PARA ID DE EMPLOYEES
CREATE SEQUENCE SQ_EMPLOYEES
START WITH 21
INCREMENT BY 1;

----TRIGGER PARA SQ EMPLOYEES
CREATE OR REPLACE TRIGGER TG_SQ_EMPLOYES
BEFORE INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
    :NEW.EMPLOYEE_ID := SQ_EMPLOYEES.NEXTVAL;
END;


/*
    EJERCICIO #5: Crear una función que obtenga el mayor salario que se paga en la empresa y retorne este valor más los datos del empleado o empleados que ganan dicho salario. Los datos de los empleados se deben retornar en un cursor mediante un parámetro de salida.
*/

CREATE OR REPLACE FUNCTION FN_MAX_SALARY 
RETURN NUMBER
IS
    MAX_SALARY NUMBER;
BEGIN 
    SELECT MAX(SALARY) INTO MAX_SALARY FROM EMPLOYEES;
    RETURN MAX_SALARY;
END;

CREATE OR REPLACE FUNCTION FN_EMPLOYEES_MAX_SALARY
RETURN SYS_REFCURSOR
IS
    SALARIO_MAXIMO NUMBER;
    CDATOS SYS_REFCURSOR;
BEGIN
    SALARIO_MAXIMO := FN_MAX_SALARY;
    OPEN CDATOS FOR 
    SELECT * FROM EMPLOYEES WHERE EMPLOYEES.SALARY = SALARIO_MAXIMO;
    RETURN CDATOS;
END;

--- Ejecución del ejercicio 5
DECLARE
    DATOS_EMPLOYEE SYS_REFCURSOR;
    REGISTRO_E EMPLOYEES%ROWTYPE;
BEGIN 
    DATOS_EMPLOYEE:= FN_EMPLOYEES_MAX_SALARY;
    LOOP 
        FETCH DATOS_EMPLOYEE INTO REGISTRO_E;
        EXIT WHEN DATOS_EMPLOYEE%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID: '|| REGISTRO_E.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('FIRST NAME: '|| REGISTRO_E.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('LAST NAME: '|| REGISTRO_E.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('EMAIL: '|| REGISTRO_E.EMAIL);
        DBMS_OUTPUT.PUT_LINE('PHONE: '|| REGISTRO_E.PHONE_NUMBER);
        DBMS_OUTPUT.PUT_LINE('DATE: '|| REGISTRO_E.HIRE_DATE);
        DBMS_OUTPUT.PUT_LINE('JOB ID: '|| REGISTRO_E.JOB_ID);
        DBMS_OUTPUT.PUT_LINE('SALARY: '|| REGISTRO_E.SALARY);
        DBMS_OUTPUT.PUT_LINE('COMISSION: '|| REGISTRO_E.COMMISSION_PCT);
        DBMS_OUTPUT.PUT_LINE('MANAGER ID: '|| REGISTRO_E.MANAGER_ID);
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT ID: '|| REGISTRO_E.DEPARTMENT_ID);
        DBMS_OUTPUT.PUT_LINE(CHR(13));
    END LOOP;
    CLOSE DATOS_EMPLOYEE;
END;

/*
    EJERCICIO #6: Crear un procedimiento almacenado que haga uso de la función creada en el inciso anterior para imprimir el nombre completo del empleado o empleados, el ID del empleado, el salario y el ID del departamento del empleado.
*/

CREATE OR REPLACE PROCEDURE SP_INFO_EMPLOYEE_MAX_SALARY 
IS
    DATOS_EMPLOYEE SYS_REFCURSOR;
    REGISTRO_EMPLOYEES EMPLOYEES%ROWTYPE;
BEGIN 
    DATOS_EMPLOYEE:= FN_EMPLOYEES_MAX_SALARY;
    LOOP 
        FETCH DATOS_EMPLOYEE INTO REGISTRO_EMPLOYEES;
        EXIT WHEN DATOS_EMPLOYEE%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE ID: '|| REGISTRO_EMPLOYEES.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('NOMBRE COMPLETO: '|| REGISTRO_EMPLOYEES.FIRST_NAME||' '|| REGISTRO_EMPLOYEES.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('SALARIO: '|| REGISTRO_EMPLOYEES.SALARY);
        DBMS_OUTPUT.PUT_LINE('DEPARTMENT ID: '|| REGISTRO_EMPLOYEES.DEPARTMENT_ID);
        DBMS_OUTPUT.PUT_LINE(CHR(13));
    END LOOP;
    CLOSE DATOS_EMPLOYEE;
END;


--- Ejecución del ejercicio 6
BEGIN 
    SP_INFO_EMPLOYEE_MAX_SALARY ;
END;


/*
    EJERCICIO #7:Crear un paquete llamado INF_EMPRESA que debe contener lo siguiente:
        • Un procedimiento que inserte registros en la tabla locations y countries y en caso de existir algún error al guardar los datos en una de las dos tablas, todos los cambios deben ser deshechos o anulados.
        • Una función que busque el total de empleados que ganan un salario entre 9000 y 20000, este valor debe ser retornado en un mensaje que diga lo siguiente: “La cantidad de empleados con un salario entre 9000 y 20000 es: x” donde x representa la cantidad de empleados que cumplen con este criterio.
*/

CREATE OR REPLACE PACKAGE PK_INF_EMPRESA
IS
    PROCEDURE SP_INSERT_LOC_AND_COU(ID_COUNTRY COUNTRIES.COUNTRY_ID%TYPE, NAME_COUNTRY COUNTRIES.COUNTRY_NAME%TYPE, CT_REGION_ID COUNTRIES.REGION_ID%TYPE, 
        ID_LOCATION LOCATIONS.LOCATION_ID%TYPE,ADDRES_STREET LOCATIONS.STREET_ADDRESS%TYPE,CODE_POSTAL LOCATIONS.POSTAL_CODE%TYPE,CITY_ID LOCATIONS.CITY%TYPE,PROVIDENCE_STATE LOCATIONS.STATE_PROVINCE%TYPE,LC_ID_COUNTRY LOCATIONS.COUNTRY_ID%TYPE );
    FUNCTION FN_FIND_EMPLOYEES_FOR_SALARY RETURN VARCHAR2;
END;

CREATE OR REPLACE PACKAGE BODY PK_INF_EMPRESA
IS 
    PROCEDURE SP_INSERT_LOC_AND_COU(ID_COUNTRY COUNTRIES.COUNTRY_ID%TYPE, NAME_COUNTRY COUNTRIES.COUNTRY_NAME%TYPE, CT_REGION_ID COUNTRIES.REGION_ID%TYPE, 
        ID_LOCATION LOCATIONS.LOCATION_ID%TYPE,ADDRES_STREET LOCATIONS.STREET_ADDRESS%TYPE,CODE_POSTAL LOCATIONS.POSTAL_CODE%TYPE,CITY_ID LOCATIONS.CITY%TYPE,PROVIDENCE_STATE LOCATIONS.STATE_PROVINCE%TYPE,LC_ID_COUNTRY LOCATIONS.COUNTRY_ID%TYPE )
    IS
    BEGIN
    -- INSERT EN LA TABLA COUNTRIES
    INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES (ID_COUNTRY, NAME_COUNTRY, CT_REGION_ID);
    COMMIT;
    -- INSERT EN LA TABLA LOCATIONS
    INSERT INTO LOCATIONS(LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) VALUES(ID_LOCATION,ADDRES_STREET,CODE_POSTAL ,CITY_ID,PROVIDENCE_STATE,LC_ID_COUNTRY); 
    COMMIT;
    EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODIGO ERROR :'|| SQLCODE);
        DBMS_OUTPUT.PUT_LINE('MENSAJE: '|| SQLERRM);
        ROLLBACK;
    END;

    FUNCTION FN_FIND_EMPLOYEES_FOR_SALARY 
    RETURN VARCHAR2
    IS 
        MENSAJE VARCHAR2(500);
        CANTIDAD_EMPLOYEES NUMBER;
    BEGIN 
    SELECT COUNT(EMPLOYEE_ID) INTO CANTIDAD_EMPLOYEES FROM EMPLOYEES WHERE EMPLOYEES.SALARY >= 9000 AND EMPLOYEES.SALARY <= 20000; 
    MENSAJE:='LA CANTIDAD DE EMPLEADOS CON UN SALARIO ENTRE 9000 Y 20000 ES: '||CANTIDAD_EMPLOYEES;
    RETURN MENSAJE;
    END;
END;


-- Ejecución del ejercicio 7
DECLARE
    MENSAJE VARCHAR2(1000);
BEGIN
    MENSAJE:= PK_INF_EMPRESA.FN_FIND_EMPLOYEES_FOR_SALARY;
    DBMS_OUTPUT.put_line(MENSAJE);
    PK_INF_EMPRESA.SP_INSERT_LOC_AND_COU('HN','Honduras',2,1000,'VO','01111','Tegucigalpa', 'FM','HN');
END;