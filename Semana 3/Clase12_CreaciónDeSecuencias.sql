/*
    DEFINICIÓN DE SECUENCIA: Una secuencia es un objeto que creamos en PL/SQL para poder usar valores secuenciales eestos valores se pueden usar en campos autoincrementales en las bases de datps.
*/
CREATE SEQUENCE SQ_TABLA_CATEGORIAS
START WITH 5
INCREMENT BY 1;

INSERT INTO CATEGORIES VALUES (SQ_TABLA_CATEGORIAS.NEXTVAL, 'MINI BICICLETAS');

DECLARE
    VALOR_ACTUAL_SQ NUMBER;
BEGIN
    VALOR_ACTUAL_SQ:=SQ_TABLA_CATEGORIAS.CURRVAL;
    DBMS_OUTPUT.PUT_LINE('EL VALOR ACTUAL DE LA SECUENCIA ES: '||VALOR_ACTUAL_SQ);
    COMMIT;
END;