-- Clase 14 - Triggers (parte B)

    -- Crear un solo trigger para poder gestionar las operaciones INSERT, UPDATE o DELETE de una tabla.
CREATE OR REPLACE TRIGGER TG_CATEGORIAS
AFTER INSERT OR UPDATE OR DELETE ON CATEGORIES
FOR EACH ROW
BEGIN
    IF (INSERTING) THEN
        INSERT INTO BITACORA VALUES (SQ_BITACORA.NEXTVAL, 'SE REALIZO UN INSERT EN LA TABLA CATEGORIAS Y EL DATO NUEVO ES: '||:NEW.CATEGORY_ID||' Y EL NOMBRE DE LA CATEGORIA ES: '||:NEW.CATEGORY_NAME, SYSTIMESTAMP, USER, 'OPERACION INSERT');
    END IF;

    IF (UPDATING) THEN
        INSERT INTO BITACORA VALUES (SQ_BITACORA.NEXTVAL, 'SE REALIZO UN UPDATE EN LA TABLA CATEGORIAS Y EL DATO ANTERIOR ES: '||:OLD.CATEGORY_ID||' Y EL NOMBRE DE LA CATEGORIA ES: '||:NEW.CATEGORY_NAME, SYSTIMESTAMP, USER, 'OPERACION UPDATE');
    END IF;

    IF (DELETING) THEN
        INSERT INTO BITACORA VALUES (SQ_BITACORA.NEXTVAL, 'SE REALIZO UN DELETE EN LA TABLA CATEGORIAS Y EL DATO ELIMINADO ES: '||:OLD.CATEGORY_ID||' Y EL NOMBRE DE LA CATEGORIA ES: '||:OLD.CATEGORY_NAME, SYSTIMESTAMP, USER, 'OPERACION DELETE');
    END IF;
END;

BEGIN
    -- INSERT INTO CATEGORIES (CATEGORY_NAME) VALUES ('BMX');
    -- UPDATE CATEGORIES SET CATEGORY_NAME='BICICLETA HOLANDESA' WHERE CATEGORY_NAME='BMX';
    DELETE FROM CATEGORIES WHERE CATEGORY_NAME='BICICLETA HOLANDESA';
    COMMIT;
END;