CREATE OR REPLACE PACKAGE BODY INFORMES AS
    
    PROCEDURE INFORME_EQUIPO (C_INFORME OUT TCURSOR, NOMBRE_EQUIPO IN VARCHAR) AS
        NOMBRE_POSIBLE EQUIPOS.NOMBRE%TYPE := ' ';
        NOMBRE_EQUIPO2 EQUIPOS.NOMBRE%TYPE := NULL;
    BEGIN
        SELECT NOMBRE INTO NOMBRE_POSIBLE FROM EQUIPOS WHERE NOMBRE LIKE NOMBRE_EQUIPO;
        SELECT NOMBRE INTO NOMBRE_EQUIPO2 FROM EQUIPOS WHERE NOMBRE = NOMBRE_EQUIPO;
        OPEN C_INFORME FOR
        -- Se sacarán los datos de la vista V_INFO_EQUIPOS.
        SELECT * FROM V_INFO_EQUIPOS WHERE UPPER(NOMBRE) = UPPER(NOMBRE_EQUIPO);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                IF NOMBRE_POSIBLE = ' ' THEN
                    RAISE_APPLICATION_ERROR(-01403, 'NOMBRE DE EQUIPO INCORRECTO');
                ELSE
                    RAISE_APPLICATION_ERROR(-01403, 'NOMBRE DE EQUIPO INCORRECTO. EL NOMBRE MAS PARECIDO ES' || NOMBRE_POSIBLE);
                END IF;
        END INFORME_EQUIPO;
            

    
    PROCEDURE INFORME_PARTIDOS_POR_JORNADA (C_PARTIDOS OUT TCURSOR) AS
    BEGIN
        
            OPEN C_PARTIDOS FOR 
            SELECT
                S.TIPO TIPO_SPLIT,
                J.NUM_JORNADA NUMERO_JORNADA,
                J.TIPO TIPO_JORNADA,
                P.*,
                (SELECT NOMBRE FROM EQUIPOS WHERE ID = ID_EQUIPO1) EQUIPO1,
                (SELECT NOMBRE FROM EQUIPOS WHERE ID = ID_EQUIPO2) EQUIPO2
            FROM SPLIT S, JORNADAS J, PARTIDOS P
            WHERE S.ID=J.ID_SPLIT AND J.ID=P.ID_JORNADA
            AND S.ID=(SELECT MAX(ID) FROM SPLIT);
    END INFORME_PARTIDOS_POR_JORNADA;
    
END INFORMES;