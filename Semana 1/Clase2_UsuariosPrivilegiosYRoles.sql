-- Clase 2 - Usuarios, privilegios, roles, restaurar base de datos
-- *NOTA: Todo esto se debe realizar en la conexión del usuario principal del sistema (SYSTEM).

    -- Crear un usuario
CREATE USER BD_BICLETAS IDENTIFIED BY 12345
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

    -- Crear un rol
CREATE ROLE ADMINISTRADORES;

    -- Creaciòn de privilegios
GRANT CREATE SESSION, CREATE ANY TABLE, CREATE ANY PROCEDURE, ALTER ANY TABLE, ALTER ANY PROCEDURE,
	DROP ANY TABLE, DROP ANY PROCEDURE TO ADMINISTRADORES;

    -- Asignaciòn de privilegios al rol
GRANT ADMINISTRADORES TO BD_BICLETAS;

    -- ! Consulta para verificar los roles creados
SELECT * FROM DBA_ROLES;

    -- ! Consulta para verificar los privilegios asignados al rol
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE='ADMINISTRADORES';
