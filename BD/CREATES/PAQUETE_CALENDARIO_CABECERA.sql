CREATE OR REPLACE PACKAGE GESTION_CALENDARIO AS
    PROCEDURE CREAR_SPLIT(TIPO_SPLIT IN VARCHAR);
    PROCEDURE GENERAR_ENFRENTAMIENTOS;
END GESTION_CALENDARIO;

