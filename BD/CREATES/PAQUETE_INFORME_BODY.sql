CREATE OR REPLACE PACKAGE BODY INFORMES AS
    
    PROCEDURE INFORME_EQUIPO (C_INFORME OUT TCURSOR) AS
    BEGIN 
        OPEN C_INFORME FOR
        -- Se sacarán los datos de la vista V_INFO_EQUIPOS.
        SELECT * FROM V_INFO_EQUIPOS;
    END INFORME_EQUIPO;
    
    PROCEDURE INFORME_PARTIDOS_POR_JORNADA (C_PARTIDOS OUT TCURSOR, NUMEROJORNADA IN NUMBER) AS
    BEGIN
        OPEN C_PARTIDOS FOR       
        -- Se sacarán los datos de una consulta.
        SELECT
            S.TIPO TIPO_SPLIT,
            J.ID ID_JORNADA,
            J.NUM_JORNADA NUMERO_JORNADA,
            J.TIPO TIPO_JORNADA,
            P.*
        FROM SPLIT S, JORNADAS J, PARTIDOS P
        WHERE S.ID=J.ID_SPLIT AND J.ID=P.ID_JORNADA
        -- El número de la jornada tiene que ser el que le hemos proporcionado.
        AND S.ID=(SELECT MAX(ID) FROM SPLIT) AND J.NUM_JORNADA=1;
        
    END INFORME_PARTIDOS_POR_JORNADA;
    
END INFORMES;