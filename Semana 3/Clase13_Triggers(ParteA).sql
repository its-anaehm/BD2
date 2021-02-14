-- Clase 13 - Triggers (parte A)
/*
    DEFINICIÓN DE TRIGGER: Un trigger es un disparador automático que se asocia a una tabla de la base de datos Y se ejecuta de forma automatica antes o despues de realizar una operacion INSERT, UPDATE o DELETE.
*/

    -- Utilizando TRIGGER para gestiona una secuencia.
CREATE OR REPLACE TRIGGER TG_SQ_TABLA_CATEGORIA
BEFORE INSERT ON CATEGORIES
FOR EACH ROW
DECLARE

BEGIN
    :NEW.CATEGORY_ID:=SQ_TABLA_CATEGORIAS.NEXTVAL;
END;

DECLARE

BEGIN
    INSERT INTO CATEGORIES (CATEGORY_NAME) VALUES('BICICLETAS URBANAS');
    COMMIT;
END;