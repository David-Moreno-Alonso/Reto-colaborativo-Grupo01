CREATE OR REPLACE PACKAGE INFORMES AS
    TYPE TCURSOR IS REF CURSOR;
    PROCEDURE INFORME (C_INFORME OUT TCURSOR);
END INFORMES;