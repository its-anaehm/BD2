-- Clase 3 - Privilegios e introducción a bloques anónimos

    /*
    -- ! La asignación de privilegis se realiza mediente la palabra reservada GRANT
    -- * Por ejemplo para que el rol administrador pueda hacer uso de la tabla BD_CENSO.PAISES y que en esta se pueda insertar, modificar o eliminar elementos sería a través de:
    GRANT SELECT ON BD_CENSO.PAISES TO ADMINISTRADOR;

    GRANT INSERT, UPDATE, DELETE ON BD_CEMSO.PAISES TO ADMINISTRADORES;
    */

    -- Construcción y declaración de un bloque anónimo
DECLARE
	nombre_completo VARCHAR2(100):='Ana Hernández';

BEGIN
	DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA PERSONA ES: '||nombre_completo);
END;

-- Para habilitar las impresiones en consola se usa la instrucción:

SET SERVEROUTPUT ON;