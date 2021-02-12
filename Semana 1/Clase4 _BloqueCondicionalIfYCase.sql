-- Clase 4 - Bloque condicional if y case

    -- Bloque anónimo que hace uso del condicional IF para validar si un empleado merece un aumento de acuerdo a la cantidad de años que lleva trabajando en la empresa.
DECLARE
	RESULTADO NUMBER(10, 2);
	PARAMETRO NUMBER(1):=1;
	PORCENTAJE NUMBER;
	SALARIO NUMBER(10,2):=12000;

BEGIN
	DBMS_OUTPUT.PUT_LINE('EL AUMENTO PARA UN EMPLEADO ES: ');
	IF (PARAMETRO=1) THEN
		PORCENTAJE:= 0.05;
		RESULTADO:=PORCENTAJE*SALARIO;
	END IF;

	DBMS_OUTPUT.PUT_LINE(RESULTADO);
END;

    -- Bloque anónimo que hace uso del condicional IF-ELIF para validar si un empleado merece un aumento de acuerdo a la cantidad de años que lleva trabajando en la empresa.
DECLARE
	RESULTADO NUMBER(10, 2);
	PARAMETRO NUMBER(1):=2;
	PORCENTAJE NUMBER;
	SALARIO NUMBER(10,2):=12000;

BEGIN
	DBMS_OUTPUT.PUT_LINE('EL AUMENTO PARA UN EMPLEADO ES: ');
	IF (PARAMETRO=1) THEN
		PORCENTAJE:= 0.05;
		RESULTADO:=PORCENTAJE*SALARIO;

	ELSIF (PARAMETRO = 2) THEN
		PORCENTAJE:=0.15;
		RESULTADO:=PORCENTAJE*SALARIO;

	ELSE
		DBMS_OUTPUT.PUT_LINE('NO SE PUEDE CALCULAR EL AUMENTO PAPS');
	END IF;

	DBMS_OUTPUT.PUT_LINE(RESULTADO);

END;

    -- Bloque anónimo que hace uso del condicional CASE para validar si un empleado merece un aumento de acuerdo a la cantidad de años que lleva trabajando en la empresa.
DECLARE
	RESULTADO NUMBER(10, 2);
	PARAMETRO NUMBER(1):=1;
	PORCENTAJE NUMBER;
	SALARIO NUMBER(10,2):=14000;

BEGIN
	DBMS_OUTPUT.PUT_LINE('EL AUMENTO PARA UN EMPLEADO ES: ');
	CASE
		WHEN (PARAMETRO=1) THEN
			PORCENTAJE:= 0.05;
			RESULTADO:=PORCENTAJE*SALARIO;

		WHEN (PARAMETRO = 2) THEN
			PORCENTAJE:=0.15;
			RESULTADO:=PORCENTAJE*SALARIO;

		ELSE
			DBMS_OUTPUT.PUT_LINE('NO SE PUEDE CALCULAR EL AUMENTO PAPS');
	END CASE;

	DBMS_OUTPUT.PUT_LINE(RESULTADO);
END;