-- Banco de Sangre (Loja, Ecuador) - Creación de tablas (DDL)
-- MySQL 8.0.16 o superior

CREATE DATABASE IF NOT EXISTS banco_sangre CHARACTER SET utf8mb4;
USE banco_sangre;

CREATE TABLE TIPO_SANGRE (
    id_tipo     INT         NOT NULL AUTO_INCREMENT,
    grupo_abo   VARCHAR(2)  NOT NULL,
    factor_rh   CHAR(1)     NOT NULL,
    PRIMARY KEY (id_tipo),
    CONSTRAINT uq_tipo_sangre UNIQUE (grupo_abo, factor_rh),
    CONSTRAINT ck_tipo_grupo  CHECK (grupo_abo IN ('O', 'A', 'B', 'AB')),
    CONSTRAINT ck_tipo_rh     CHECK (factor_rh IN ('+', '-'))
);

CREATE TABLE COMPATIBILIDAD (
    id_tipo_donante   INT         NOT NULL,
    id_tipo_receptor  INT         NOT NULL,
    componente        VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_tipo_donante, id_tipo_receptor, componente),
    CONSTRAINT ck_compat_componente CHECK (componente IN ('CGR', 'PLASMA',
                                                          'PLAQUETAS')),
    CONSTRAINT fk_compat_donante  FOREIGN KEY (id_tipo_donante)
        REFERENCES TIPO_SANGRE (id_tipo),
    CONSTRAINT fk_compat_receptor FOREIGN KEY (id_tipo_receptor)
        REFERENCES TIPO_SANGRE (id_tipo)
);

CREATE TABLE BANCO_SANGRE (
    id_banco              INT          NOT NULL AUTO_INCREMENT,
    nombre                VARCHAR(120) NOT NULL,
    tipo_establecimiento  VARCHAR(60)  NOT NULL,
    provincia             VARCHAR(40)  NOT NULL,
    canton                VARCHAR(40)  NOT NULL,
    direccion             VARCHAR(150),
    PRIMARY KEY (id_banco),
    CONSTRAINT uq_banco_nombre UNIQUE (nombre)
);

CREATE TABLE HOSPITAL (
    id_establecimiento  INT          NOT NULL AUTO_INCREMENT,
    nombre              VARCHAR(120) NOT NULL,
    tipo                VARCHAR(60)  NOT NULL,
    canton              VARCHAR(40)  NOT NULL,
    codigo_msp          VARCHAR(20),
    PRIMARY KEY (id_establecimiento),
    CONSTRAINT uq_hospital_nombre UNIQUE (nombre),
    CONSTRAINT uq_hospital_codigo UNIQUE (codigo_msp)
);

CREATE TABLE PERSONAL_SALUD (
    id_personal          INT          NOT NULL AUTO_INCREMENT,
    nombres              VARCHAR(100) NOT NULL,
    cargo                VARCHAR(30)  NOT NULL,
    registro_profesional VARCHAR(30),
    institucion          VARCHAR(120),
    PRIMARY KEY (id_personal),
    CONSTRAINT uq_personal_registro UNIQUE (registro_profesional),
    CONSTRAINT ck_personal_cargo    CHECK (cargo IN ('MEDICO', 'ENFERMERIA',
                                                     'LABORATORIO'))
);

CREATE TABLE DONANTE (
    cedula                 CHAR(10)     NOT NULL,
    nombres                VARCHAR(80)  NOT NULL,
    apellidos              VARCHAR(80)  NOT NULL,
    fecha_nacimiento       DATE         NOT NULL,
    sexo                   CHAR(1)      NOT NULL,
    telefono               VARCHAR(15),
    canton_residencia      VARCHAR(40),
    ocupacion              VARCHAR(60),
    fecha_ultima_donacion  DATE,
    id_tipo                INT          NOT NULL,
    PRIMARY KEY (cedula),
    CONSTRAINT ck_donante_sexo   CHECK (sexo IN ('M', 'F')),
    CONSTRAINT ck_donante_ultima CHECK (fecha_ultima_donacion IS NULL
                                        OR fecha_ultima_donacion > fecha_nacimiento),
    CONSTRAINT fk_donante_tipo   FOREIGN KEY (id_tipo)
        REFERENCES TIPO_SANGRE (id_tipo)
);

CREATE TABLE FORMULARIO_DONACION (
    id_formulario       INT          NOT NULL AUTO_INCREMENT,
    cedula              CHAR(10)     NOT NULL,
    fecha               DATE         NOT NULL,
    consentimiento      CHAR(2)      NOT NULL,
    tatuaje_reciente    CHAR(2)      NOT NULL,
    viaje_reciente      CHAR(2)      NOT NULL,
    medicamentos        VARCHAR(100),
    enfermedades        VARCHAR(100),
    conducta_riesgo     CHAR(2)      NOT NULL,
    embarazo_lactancia  CHAR(2)      NOT NULL DEFAULT 'NO',
    resultado           VARCHAR(10)  NOT NULL,
    PRIMARY KEY (id_formulario),
    CONSTRAINT ck_form_consent   CHECK (consentimiento IN ('SI', 'NO')),
    CONSTRAINT ck_form_tatuaje   CHECK (tatuaje_reciente IN ('SI', 'NO')),
    CONSTRAINT ck_form_viaje     CHECK (viaje_reciente IN ('SI', 'NO')),
    CONSTRAINT ck_form_conducta  CHECK (conducta_riesgo IN ('SI', 'NO')),
    CONSTRAINT ck_form_embarazo  CHECK (embarazo_lactancia IN ('SI', 'NO')),
    CONSTRAINT ck_form_resultado CHECK (resultado IN ('APTO', 'NO_APTO')),
    CONSTRAINT fk_form_donante   FOREIGN KEY (cedula)
        REFERENCES DONANTE (cedula)
);

CREATE TABLE EXAMEN_FISICO (
    id_examen         INT           NOT NULL AUTO_INCREMENT,
    id_formulario     INT           NOT NULL,
    peso_kg           DECIMAL(5,2)  NOT NULL,
    talla_cm          DECIMAL(5,1),
    presion_arterial  VARCHAR(7)    NOT NULL,
    pulso             INT           NOT NULL,
    temperatura       DECIMAL(4,1)  NOT NULL,
    hemoglobina       DECIMAL(4,1)  NOT NULL,
    resultado         VARCHAR(10)   NOT NULL,
    PRIMARY KEY (id_examen),
    CONSTRAINT uq_examen_formulario UNIQUE (id_formulario),
    CONSTRAINT ck_examen_peso       CHECK (peso_kg > 0 AND peso_kg < 300),
    CONSTRAINT ck_examen_pulso      CHECK (pulso BETWEEN 30 AND 220),
    CONSTRAINT ck_examen_temp       CHECK (temperatura BETWEEN 30 AND 45),
    CONSTRAINT ck_examen_hb         CHECK (hemoglobina > 0 AND hemoglobina < 25),
    CONSTRAINT ck_examen_resultado  CHECK (resultado IN ('APTO', 'NO_APTO')),
    CONSTRAINT fk_examen_formulario FOREIGN KEY (id_formulario)
        REFERENCES FORMULARIO_DONACION (id_formulario)
);

CREATE TABLE ENTREVISTA_MEDICA (
    id_entrevista           INT          NOT NULL AUTO_INCREMENT,
    id_examen               INT          NOT NULL,
    id_personal             INT          NOT NULL,
    fecha                   DATE         NOT NULL,
    observaciones           VARCHAR(200),
    decision                VARCHAR(10)  NOT NULL,
    motivo_diferimiento     VARCHAR(120),
    fecha_fin_diferimiento  DATE,
    PRIMARY KEY (id_entrevista),
    CONSTRAINT uq_entrevista_examen UNIQUE (id_examen),
    CONSTRAINT ck_entrevista_decision CHECK (decision IN ('APTO', 'DIFERIDO',
                                                          'RECHAZADO')),
    CONSTRAINT ck_entrevista_dif CHECK (
        (decision = 'DIFERIDO' AND fecha_fin_diferimiento IS NOT NULL)
        OR (decision <> 'DIFERIDO' AND fecha_fin_diferimiento IS NULL)),
    CONSTRAINT fk_entrevista_examen   FOREIGN KEY (id_examen)
        REFERENCES EXAMEN_FISICO (id_examen),
    CONSTRAINT fk_entrevista_personal FOREIGN KEY (id_personal)
        REFERENCES PERSONAL_SALUD (id_personal)
);

CREATE TABLE DONACION (
    id_donacion       INT          NOT NULL AUTO_INCREMENT,
    id_entrevista     INT          NOT NULL,
    id_personal       INT          NOT NULL,
    id_banco          INT          NOT NULL,
    fecha_hora        DATETIME     NOT NULL,
    tipo_donacion     VARCHAR(20)  NOT NULL DEFAULT 'SANGRE_TOTAL',
    volumen_ml        INT          NOT NULL,
    reaccion_adversa  VARCHAR(60)  NOT NULL DEFAULT 'NINGUNA',
    estado            VARCHAR(12)  NOT NULL DEFAULT 'COMPLETA',
    PRIMARY KEY (id_donacion),
    CONSTRAINT uq_donacion_entrevista UNIQUE (id_entrevista),
    CONSTRAINT ck_donacion_tipo   CHECK (tipo_donacion IN ('SANGRE_TOTAL',
                                                          'AFERESIS')),
    CONSTRAINT ck_donacion_vol    CHECK (volumen_ml > 0 AND volumen_ml <= 600),
    CONSTRAINT ck_donacion_estado CHECK (estado IN ('COMPLETA', 'INCOMPLETA')),
    CONSTRAINT fk_donacion_entrevista FOREIGN KEY (id_entrevista)
        REFERENCES ENTREVISTA_MEDICA (id_entrevista),
    CONSTRAINT fk_donacion_personal   FOREIGN KEY (id_personal)
        REFERENCES PERSONAL_SALUD (id_personal),
    CONSTRAINT fk_donacion_banco      FOREIGN KEY (id_banco)
        REFERENCES BANCO_SANGRE (id_banco)
);

CREATE TABLE UNIDAD_SANGRE (
    codigo_unidad      VARCHAR(20)  NOT NULL,
    id_donacion        INT          NOT NULL,
    id_tipo            INT          NOT NULL,
    componente         VARCHAR(20)  NOT NULL,
    volumen_ml         INT          NOT NULL,
    fecha_extraccion   DATE         NOT NULL,
    fecha_caducidad    DATE         NOT NULL,
    estado             VARCHAR(15)  NOT NULL DEFAULT 'CUARENTENA',
    temperatura_almac  VARCHAR(20),
    numero_lote        VARCHAR(30),
    PRIMARY KEY (codigo_unidad),
    CONSTRAINT ck_unidad_componente CHECK (componente IN ('SANGRE_TOTAL', 'CGR',
                                                         'PLASMA', 'PLAQUETAS')),
    CONSTRAINT ck_unidad_volumen    CHECK (volumen_ml > 0),
    CONSTRAINT ck_unidad_fechas     CHECK (fecha_caducidad > fecha_extraccion),
    CONSTRAINT ck_unidad_estado     CHECK (estado IN ('CUARENTENA', 'DISPONIBLE',
                                        'RESERVADA', 'TRANSFUNDIDA',
                                        'DESCARTADA', 'CADUCADA')),
    CONSTRAINT fk_unidad_donacion FOREIGN KEY (id_donacion)
        REFERENCES DONACION (id_donacion),
    CONSTRAINT fk_unidad_tipo     FOREIGN KEY (id_tipo)
        REFERENCES TIPO_SANGRE (id_tipo)
);

CREATE TABLE PRUEBA_TAMIZAJE (
    id_prueba      INT          NOT NULL AUTO_INCREMENT,
    id_donacion    INT          NOT NULL,
    marcador       VARCHAR(20)  NOT NULL,
    fecha          DATE         NOT NULL,
    metodo         VARCHAR(40),
    resultado      VARCHAR(15)  NOT NULL,
    lote_reactivo  VARCHAR(30),
    PRIMARY KEY (id_prueba),
    CONSTRAINT uq_prueba_marcador  UNIQUE (id_donacion, marcador),
    CONSTRAINT ck_prueba_marcador  CHECK (marcador IN ('VIH', 'HEPATITIS_B',
                                         'HEPATITIS_C', 'SIFILIS', 'CHAGAS',
                                         'HTLV')),
    CONSTRAINT ck_prueba_resultado CHECK (resultado IN ('REACTIVO',
                                                        'NO_REACTIVO')),
    CONSTRAINT fk_prueba_donacion  FOREIGN KEY (id_donacion)
        REFERENCES DONACION (id_donacion)
);

CREATE TABLE PACIENTE (
    cedula_paciente   CHAR(10)     NOT NULL,
    id_tipo           INT          NOT NULL,
    nombres           VARCHAR(80)  NOT NULL,
    apellidos         VARCHAR(80)  NOT NULL,
    fecha_nacimiento  DATE         NOT NULL,
    historia_clinica  VARCHAR(20),
    diagnostico       VARCHAR(150),
    PRIMARY KEY (cedula_paciente),
    CONSTRAINT uq_paciente_historia UNIQUE (historia_clinica),
    CONSTRAINT fk_paciente_tipo     FOREIGN KEY (id_tipo)
        REFERENCES TIPO_SANGRE (id_tipo)
);

CREATE TABLE SOLICITUD_TRANSFUSION (
    id_solicitud        INT          NOT NULL AUTO_INCREMENT,
    cedula_paciente     CHAR(10)     NOT NULL,
    id_establecimiento  INT          NOT NULL,
    fecha_solicitud     DATE         NOT NULL,
    componente          VARCHAR(20)  NOT NULL,
    cantidad_unidades   INT          NOT NULL,
    urgencia            VARCHAR(12)  NOT NULL DEFAULT 'RUTINA',
    diagnostico         VARCHAR(150),
    estado              VARCHAR(12)  NOT NULL DEFAULT 'PENDIENTE',
    medico_solicitante  VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_solicitud),
    CONSTRAINT ck_sol_componente CHECK (componente IN ('SANGRE_TOTAL', 'CGR',
                                                      'PLASMA', 'PLAQUETAS')),
    CONSTRAINT ck_sol_cantidad   CHECK (cantidad_unidades > 0),
    CONSTRAINT ck_sol_urgencia   CHECK (urgencia IN ('RUTINA', 'URGENTE',
                                                    'EMERGENCIA')),
    CONSTRAINT ck_sol_estado     CHECK (estado IN ('PENDIENTE', 'ATENDIDA',
                                                  'CANCELADA')),
    CONSTRAINT fk_sol_paciente   FOREIGN KEY (cedula_paciente)
        REFERENCES PACIENTE (cedula_paciente),
    CONSTRAINT fk_sol_hospital   FOREIGN KEY (id_establecimiento)
        REFERENCES HOSPITAL (id_establecimiento)
);

CREATE TABLE ASIGNACION (
    codigo_unidad    VARCHAR(20)  NOT NULL,
    id_solicitud     INT          NOT NULL,
    fecha_entrega    DATE,
    prueba_cruzada   CHAR(2)      NOT NULL,
    resultado_compat VARCHAR(15)  NOT NULL,
    PRIMARY KEY (codigo_unidad, id_solicitud),
    CONSTRAINT ck_asig_prueba    CHECK (prueba_cruzada IN ('SI', 'NO')),
    CONSTRAINT ck_asig_resultado CHECK (resultado_compat IN ('COMPATIBLE',
                                                             'INCOMPATIBLE')),
    CONSTRAINT fk_asig_unidad    FOREIGN KEY (codigo_unidad)
        REFERENCES UNIDAD_SANGRE (codigo_unidad),
    CONSTRAINT fk_asig_solicitud FOREIGN KEY (id_solicitud)
        REFERENCES SOLICITUD_TRANSFUSION (id_solicitud)
);

CREATE TABLE MOVIMIENTO_UNIDAD (
    id_movimiento      INT          NOT NULL AUTO_INCREMENT,
    codigo_unidad      VARCHAR(20)  NOT NULL,
    fecha_hora         DATETIME     NOT NULL,
    tipo_movimiento    VARCHAR(20)  NOT NULL,
    ubicacion_origen   VARCHAR(80),
    ubicacion_destino  VARCHAR(80),
    responsable        VARCHAR(100) NOT NULL,
    observacion        VARCHAR(150),
    PRIMARY KEY (id_movimiento),
    CONSTRAINT ck_mov_tipo CHECK (tipo_movimiento IN ('INGRESO',
                                  'ALMACENAMIENTO', 'DESPACHO', 'TRANSFUSION',
                                  'DESCARTE')),
    CONSTRAINT fk_mov_unidad FOREIGN KEY (codigo_unidad)
        REFERENCES UNIDAD_SANGRE (codigo_unidad)
);
