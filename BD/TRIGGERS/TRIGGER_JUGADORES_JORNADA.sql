CREATE OR REPLACE TRIGGER JUGADORES_JORNADA_TRG
BEFORE INSERT OR UPDATE OR DELETE ON JUGADORES
FOR EACH ROW
DECLARE
V_SPLIT_ESTADO VARCHAR2(10);
V_ID_JORNADA NUMBER;
JORNADA_EXISTENTE EXCEPTION;
BEGIN
  SELECT ESTADO INTO V_SPLIT_ESTADO FROM SPLIT  WHERE ID IN (SELECT MAX(ID_SPLIT) FROM JORNADAS);
  IF V_SPLIT_ESTADO = 'CERRADO' THEN
    RAISE JORNADA_EXISTENTE;
    END IF;
EXCEPTION
  WHEN JORNADA_EXISTENTE THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede realizar esta operación mientras hay una jornada en curso.');
END;