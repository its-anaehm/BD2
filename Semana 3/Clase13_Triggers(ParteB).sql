--  Clase 13 - Triggers (Parte B)

    -- TRIGGER para que la tabla tenga una mejor consistencia en su contenido.
CREATE OR REPLACE TRIGGER TG_UPDATE_BRANDS
BEFORE UPDATE ON BRANDS
FOR EACH ROW
DECLARE

BEGIN
    :NEW.BRAND_NAME:=TRIM(UPPER(:NEW.BRAND_NAME));
END;

BEGIN
    UPDATE BRANDS SET BRAND_NAME=' tn bike ' WHERE BRAND_ID=13;
    COMMIT;
END;

SELECT * FROM BRANDS;