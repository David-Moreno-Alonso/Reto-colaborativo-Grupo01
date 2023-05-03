DROP TABLE XML_JORNADA;
DROP TABLE XML_CLASIFICACION;
DROP TABLE XML_COMPLETO;
DROP TABLE USUARIOS;
DROP TABLE CONTRATOS_PERSONAL CASCADE CONSTRAINTS;
DROP TABLE PERSONALES CASCADE CONSTRAINTS;
DROP TABLE CONTRATOS_JUGADORES CASCADE CONSTRAINTS;
DROP TABLE JUGADORES CASCADE CONSTRAINTS;
DROP TABLE PARTIDOS CASCADE CONSTRAINTS;
DROP TABLE EQUIPOS CASCADE CONSTRAINTS;
DROP TABLE JORNADAS CASCADE CONSTRAINTS;
DROP TABLE SPLIT CASCADE CONSTRAINTS;
DROP SEQUENCE NUM_JORNADA;



CREATE SEQUENCE NUM_JORNADA INCREMENT BY 1 START WITH 1 MAXVALUE 13 CYCLE NOCACHE;
CREATE TABLE SPLIT
(
ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT SPL_ID_PK PRIMARY KEY,
ANIO DATE NOT NULL,
TIPO VARCHAR2(10),
ESTADO VARCHAR2(10),

	CONSTRAINT SPL_TIP_CK CHECK (UPPER(TIPO) IN ('VERANO', 'INVIERNO')),
	CONSTRAINT SPL_EST_CK CHECK (UPPER(ESTADO) IN ('ABIERTO', 'CERRADO'))
);


CREATE TABLE JORNADAS 
(
    ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT  JOR_ID_PK PRIMARY KEY,
    NUM_JORNADA NUMBER(2),
    TIPO VARCHAR2(10),
    ID_SPLIT NUMBER(2),

        CONSTRAINT JOR_TIP_CK CHECK (UPPER(TIPO) IN ('NORMAL', 'PLAY-OFF')),
        CONSTRAINT JOR_IDSPLIT_FK FOREIGN KEY (ID_SPLIT) REFERENCES SPLIT(ID)

);


CREATE TABLE EQUIPOS
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT EQU_ID_PK PRIMARY KEY,
	NOMBRE VARCHAR2(30),
	PRESUPUESTO_ANUAL NUMBER(9),
    
        CONSTRAINT EQ_PRE_CK CHECK (PRESUPUESTO_ANUAL<=200000000)
);


CREATE TABLE PARTIDOS 
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT PAR_ID_PK PRIMARY KEY,
	GOLES_EQUIPO1 NUMBER(2),
	GOLES_EQUIPO2 NUMBER(2),
	FECHA DATE,
	LUGAR VARCHAR2(50),
	ID_JORNADA NUMBER(2),
	ID_EQUIPO1 NUMBER(2),
	ID_EQUIPO2 NUMBER(2),

		CONSTRAINT PAR_IDJORNADA_FK FOREIGN KEY (ID_JORNADA) REFERENCES JORNADAS(ID),
		CONSTRAINT PAR_IDEQUIPO1_FK FOREIGN KEY (ID_EQUIPO1) REFERENCES EQUIPOS(ID),
		CONSTRAINT PAR_IDEQUIPO2_FK FOREIGN KEY (ID_EQUIPO2) REFERENCES EQUIPOS(ID)
);


CREATE TABLE JUGADORES
(
	ID NUMBER(3) GENERATED ALWAYS AS IDENTITY CONSTRAINT JUG_ID_PK PRIMARY KEY,
	NOMBRE VARCHAR2(30),
	APELLIDOS VARCHAR2(50),
	DNI VARCHAR2(9),
	TELEFONO VARCHAR2(9),
	POSICION VARCHAR2(20),
    IMG VARCHAR2(250),
    TIPO VARCHAR2(15) NULL,
	VELOCIDAD NUMBER(2),
	FISICO NUMBER(2),
	TIRO NUMBER(2),
	PASE NUMBER(2),
	TALENTO NUMBER(2),
	DEFENSA NUMBER(2),
        
        CONSTRAINT JUG_TIPO_CK CHECK (UPPER(TIPO) IN ('DRAFT', 'WILD-CARD')),
        CONSTRAINT JUG_POS_CK CHECK (UPPER(POSICION) IN ('PORTERO', 'DEFENSA', 'MEDIO', 'DELANTERO')),
		CONSTRAINT JUG_VEL_CK CHECK (VELOCIDAD BETWEEN 0 AND 99),
		CONSTRAINT JUG_FIS_CK CHECK (FISICO BETWEEN 0 AND 99),
		CONSTRAINT JUG_TIRO_CK CHECK (TIRO BETWEEN 0 AND 99),
		CONSTRAINT JUG_PASE_CK CHECK (PASE BETWEEN 0 AND 99),
		CONSTRAINT JUG_TALE_CK CHECK (TALENTO BETWEEN 0 AND 99),
		CONSTRAINT JUG_DEF_CK CHECK (DEFENSA BETWEEN 0 AND 99)
);


CREATE TABLE CONTRATOS_JUGADORES
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT CONJUG_ID_PK PRIMARY KEY,
	ID_EQUIPO NUMBER(2),
	ID_JUGADOR NUMBER(3),
	FECHA_INICIO DATE,
	FECHA_FIN DATE,
	CLAUSULA NUMBER(9),
	DORSAL VARCHAR2(2),
	SUELDO NUMBER(9),

		CONSTRAINT CONTRAJUG_IDEQUIPO_FK FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS(ID),
		CONSTRAINT CONTRAJUG_IDJUG_FK FOREIGN KEY (ID_JUGADOR) REFERENCES JUGADORES(ID),
		CONSTRAINT CONTRAJUG_CLAU_CK CHECK (CLAUSULA > 1000000),
		CONSTRAINT CONTRAJUG_DOR_CK CHECK (DORSAL BETWEEN 0 AND 99),
		CONSTRAINT CONTRAJUG_SUEL_CK CHECK (SUELDO IN (10000000, 15000000, 10500000, 22500000))
);


CREATE TABLE PERSONALES
(
	ID NUMBER(3) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT PERS_ID_PK PRIMARY KEY,
	NOMBRE VARCHAR2(30),
	APELLIDOS VARCHAR2(50),
	DNI VARCHAR2(9),
	TELEFONO VARCHAR2(9),
	OFICIO VARCHAR2(20),
    IMG VARCHAR2(250),
    
		CONSTRAINT PERS_OFI_CK CHECK (UPPER(OFICIO) IN (UPPER('PRESIDENTE'), UPPER('ENTRENADOR')))
);


CREATE TABLE CONTRATOS_PERSONAL
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT CONPER_ID_PK PRIMARY KEY,
	ID_PERSONAL NUMBER(3),
	ID_EQUIPO NUMBER(2),
	FECHA_INICIO DATE,
	FECHA_FIN DATE,
	SUELDO NUMBER(9),

		CONSTRAINT CONPER_IDEQUIPO_FK FOREIGN KEY (ID_EQUIPO) REFERENCES EQUIPOS(ID),
		CONSTRAINT CONPER_IDPERSONAL_FK FOREIGN KEY (ID_PERSONAL) REFERENCES PERSONALES(ID)
);


CREATE TABLE USUARIOS
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT USU_ID_PK PRIMARY KEY,
	NOMBRE VARCHAR2(30),
	CONTRASEÑA VARCHAR2(30),
	CORREO VARCHAR2(50),
	TIPO VARCHAR2(10),

		CONSTRAINT USU_TIPO_CK CHECK (UPPER(TIPO) IN (UPPER('USUARIO'), UPPER('ADMIN')))
);


CREATE TABLE XML_COMPLETO
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT XMLCOM_ID_PK PRIMARY KEY,
	RESUL CLOB
);


CREATE TABLE XML_CLASIFICACION
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT XMLCLA_ID_PK PRIMARY KEY,
	RESUL CLOB
);


CREATE TABLE XML_JORNADA
(
	ID NUMBER(2) GENERATED ALWAYS AS IDENTITY MAXVALUE 999 CONSTRAINT XMLJOR_ID_PK PRIMARY KEY,
	RESUL CLOB
);